
def result_dictionary_dish(file,cook_book):
    with open(file) as f:
            count=0
            f=f.read().splitlines()
            for line in f:
                if line.isdigit():
                    count=int(line)
                    continue
                elif count>0:
                    ingredient_name,quantity,measure = line.split(' | ')
                    info_recipe={
                        'ingredient_name':ingredient_name,
                        'quantity':quantity,
                        'measure':measure
                        }
                    cook_book[name_dish].append(info_recipe)
                    count=count-1          
                elif line=='':
                    continue
                else:
                    name_dish=line
                    cook_book[name_dish]=[]
            #print(cook_book)
    return(cook_book)
       
def get_name_dish(file,cook_book):
    with open(file) as f:
            count=0
            f=f.read().splitlines()
            for line in f:
                if line.isdigit():
                    count=int(line)
                    continue
                elif count>0:
                    count=count-1          
                elif line=='':
                    continue
                else:
                    name_dish=line
                    cook_book[name_dish]=[]
            #print(cook_book)
    return(cook_book)

def get_shop_list_by_dishes(dishes, person_count):
    cook_book = {}
    dict_recipes_for_dish={}
    cook_book=result_dictionary_dish('recipes.txt', cook_book)
    for id_dishes in dishes:
        for dish,recipe in cook_book.items():
            if id_dishes==dish:
              for variables in recipe: 
                 ingredient_name=variables.get('ingredient_name')
                 quantity=int(variables.get('quantity'))*person_count
                 measure=variables.get('measure')
                 info_recipe={
                           'measure':measure,
                           'quantity':quantity
                 }
                 dict_recipes_for_dish[ingredient_name]=info_recipe
    return dict_recipes_for_dish

def main():
    cook_book = {}
    cook_book=get_name_dish('recipes.txt', cook_book)
    cook_book=result_dictionary_dish('recipes.txt', cook_book)
    print(cook_book,'\n')
    print(get_shop_list_by_dishes(['Запеченный картофель', 'Омлет'], 2))
    
main()







#RESULT = {}
#with open('recipes', 'r', encoding='utf-8') as file:
#   lines = file.read().splitlines()
#   is_recipe_name = True
#   recipe_name = ''
#
#   for line in lines:
#       if line == '':
#           is_recipe_name = True
#           continue
#
#       if is_recipe_name:
#           recipe_name = line
#           is_recipe_name = False
#           RESULT[recipe_name] = []
#           continue
#
#       if line.isdigit():
#           counter = int(line)
#           continue
#
#       ingredient_name, quantity, measure = line.split('|')
#       info_ingredient = {
#           'ingredient_name': ingredient_name,
#           'quantity': quantity,
#           'measure': measure
#       }
#       RESULT[recipe_name].append(info_ingredient)







