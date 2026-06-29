#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <ctype.h>

typedef struct {
  char name[64];
  int quantity;
  float price;
} Item;

#define max_items 100

void header(void);
void print_help(void);
void clear_screen(void);
void to_lower(char *str, char *result);
void add_item(Item inventory[], int *count);
void list_items(Item inventory[], int count);
void search_item(Item inventory[], int count);
void edit_item(Item inventory[], int count);
void load_from_file(Item inventory[], int *count);
void save_to_file(Item inventory[], int count);
void delete_item(Item inventory[], int *count);

int main(void) {
  int running = 1;
  char input[128];

  Item inventory[max_items];
  int item_count = 0;

  load_from_file(inventory, &item_count);
  
  header();

  while (running) {
    printf("> ");
    if (fgets(input, sizeof(input), stdin) == NULL) break;
    input[strcspn(input, "\n")] = '\0';

    if (strcmp(input, "help") == 0) print_help();
    else if (strcmp(input, "clear") == 0) clear_screen();
    else if (strcmp(input, "add") == 0) add_item(inventory, &item_count);
    else if (strcmp(input, "list") == 0) list_items(inventory, item_count);
    else if (strcmp(input, "search") == 0) search_item(inventory, item_count);
    else if (strcmp(input, "edit") == 0) edit_item(inventory, item_count);
    else if (strcmp(input, "save") == 0) save_to_file(inventory, item_count);
    else if (strcmp(input, "delete") == 0) delete_item(inventory, &item_count);
    else if (strcmp(input, "exit") == 0) {
      save_to_file(inventory, item_count);
      running = 0;
    }
    else if (strlen(input) > 0) printf("unknown command: %s\n", input);
  }
  return 0;
}

void header(void) {
  time_t t;
  struct tm *tm_info;
  char buffer[20];

  time(&t);
  tm_info = localtime(&t);
  strftime(buffer, 20, "%Y-%m-%d", tm_info);

  printf("welcome to [ inventory CLI ] | %s\n", buffer);
  printf("type 'help' for available commands.\n\n");
}

void print_help(void) {
  printf("available commands:\n");
  printf("help   - shows this message\n");
  printf("clear  - clear the screen\n");
  printf("exit   - quit the program\n");
  printf("add    - add an item to the inventory\n");
  printf("list   - list all items in the inventory\n");
  printf("search - search for an item in the inventory\n");
  printf("edit   - edit an item in the inventory\n");
  printf("save   - save the inventory to a file\n");
  printf("delete - delete an item from the inventory\n");
}

void clear_screen(void) {
  #ifdef _WIN32
    system("cls");
  #else
    system("clear");
  #endif
  header();
}

void to_lower(char *str, char *result) {
  for (int i = 0; str[i]; i++) result[i] = tolower(str[i]);
  result[strlen(str)] = '\0';
}

void add_item(Item inventory[], int *count) {
  if (*count >= max_items) {
    printf("inventory is full\n");
    return;
  }

  Item new_item;
  char buf[64];

  printf("name: ");
  fgets(new_item.name, sizeof(new_item.name), stdin);
  new_item.name[strcspn(new_item.name, "\n")] = '\0';

  printf("quantity: ");
  fgets(buf, sizeof(buf), stdin);
  buf[strcspn(buf, "\n")] = '\0';
  new_item.quantity = atoi(buf);
  if (new_item.quantity < 0) {
    printf("invalid quantity\n");
    return;
  }

  printf("price: ");
  fgets(buf, sizeof(buf), stdin);
  buf[strcspn(buf, "\n")] = '\0';
  new_item.price = atof(buf);
  if (new_item.price < 0) {
    printf("invalid price\n");
    return;
  }

  inventory[*count] = new_item;
  (*count)++;
  printf("item added successfully\n");
}

void list_items(Item inventory[], int count) {
  if (count == 0) {
    printf("inventory is empty\n");
    return;
  }

  printf("inventory:\n");
  for (int i = 0; i < count; i++) {
    printf("%d. %s - %d - $%.2f\n", i + 1, inventory[i].name, inventory[i].quantity, inventory[i].price);
  }
  printf("\n");
}

void delete_item(Item inventory[], int *count) {
  if (*count == 0) {
    printf("inventory is empty\n");
    return;
  }

  list_items(inventory, *count);
  printf("enter the number of the item to delete: ");
  char buf[64];
  fgets(buf, sizeof(buf), stdin);
  int num = atoi(buf);

  int index = num - 1;
  if (index < 0 || index >= *count) {
    printf("invalid item number\n");
    return;
  }

  char name[64];
  strcpy(name, inventory[index].name);
  for (int i = index; i < *count - 1; i++) inventory[i] = inventory[i + 1];
  (*count)--;
  printf("item '%s' deleted successfully\n", name);
}

void search_item(Item inventory[], int count) {
  if (count == 0) {
    printf("inventory is empty\n");
    return;
  }

  char keyword[64];
  printf("enter search item: ");
  fgets(keyword, sizeof(keyword), stdin);
  keyword[strcspn(keyword, "\n")] = '\0';

  int found = 0;
  for (int i = 0; i < count; i++) {
    char name_lower[64], keyword_lower[64];
    to_lower(inventory[i].name, name_lower);
    to_lower(keyword, keyword_lower);

    if (strstr(name_lower, keyword_lower) != NULL) {
      printf("%d. %s - %d - $%.2f\n", i + 1, inventory[i].name, inventory[i].quantity, inventory[i].price);
      found++;
    }
  }

  if (!found) {
    printf("no items found with keyword '%s'\n", keyword);
  } else {
    printf("found %d items with keyword '%s'\n", found, keyword);
  }
}

void edit_item(Item inventory[], int count) {
  if (count == 0) {
    printf("inventory is empty\n");
    return;
  }

  list_items(inventory, count);
  printf("enter the number of the item to edit: ");
  char buf[64];
  fgets(buf, sizeof(buf), stdin);
  int num = atoi(buf);

  int index = num - 1;
  if (index < 0 || index >= count) {
    printf("invalid item number\n");
    return;
  }

  Item *item = &inventory[index];

  printf("name [%s]: ", item->name);
  fgets(buf, sizeof(buf), stdin);
  buf[strcspn(buf, "\n")] = '\0';
  if (strlen(buf) > 0) strcpy(item->name, buf);

  printf("quantity [%d]: ", item->quantity);
  fgets(buf, sizeof(buf), stdin);
  buf[strcspn(buf, "\n")] = '\0';
  if (strlen(buf) > 0) {
    int new_quantity = atoi(buf);
    if (new_quantity < 0) {
      printf("invalid quantity\n");
    } else {
      item->quantity = new_quantity;
    }
  }

  printf("price [%.2f]: ", item->price);
  fgets(buf, sizeof(buf), stdin);
  buf[strcspn(buf, "\n")] = '\0';
  if (strlen(buf) > 0) {
    float new_price = atof(buf);
    if (new_price < 0) {
      printf("invalid price\n");
    } else {
      item->price = new_price;
    }
  }
  printf("item updated successfully\n");
}

void save_to_file(Item inventory[], int count) {
  FILE *file = fopen("inventory.csv", "w");
  if (file == NULL) {
    printf("error opening file\n");
    return;
  }

  for (int i = 0; i < count; i++) {
    fprintf(file, "%s|%d|%.2f\n", inventory[i].name, inventory[i].quantity, inventory[i].price);
  }

  fclose(file);
  printf("inventory saved to file\n");
}

void load_from_file(Item inventory[], int *count) {
  FILE *file = fopen("inventory.csv", "r");
  if (file == NULL) {
    return;
  }

  *count = 0;
  while (*count < max_items) {
    Item item;
    int result = fscanf(file, " %63[^|]|%d|%f", item.name, &item.quantity, &item.price);

    if (result != 3) break;

    inventory[*count] = item;
    (*count)++;
  }
  fclose(file);
}
