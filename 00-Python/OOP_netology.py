import sys

class Animals():
	def __init__(self,name,weight,sound=''):
		self.name=name
		self.weight=weight
		self.sound=sound
	def eat(self,food):
		self.weight=self.weight+food

class MilkMixin:
	def MilkCow(self,hour):
		self.CountMilk=self.CountMilk+hour*2;

class OviparousMixin:
	def collecting_eggs(self,count_eggs):
		self.CountEggs=self.CountEggs+count_eggs;

class Gooses(OviparousMixin,Animals):
	def __init__(self,name,weight,sound = 'Эв',CountEggs=0):
		self.CountEggs=CountEggs;
		super().__init__(name,weight,sound)
		

class Cows(MilkMixin,Animals):
	def __init__(self,name,weight,sound = 'Му',CountMilk=0):
		self.CountMilk=CountMilk;
		super().__init__(name,weight,sound)

class Sheeps(Animals):
	def __init__(self,name,weight,sound = 'Бе',	Countwool=0):
		self.Countwool=Countwool;
		super().__init__(name,weight,sound = 'Бе')
	def cut(self,hour):
		self.Countwool=self.Countwool+hour*4;

class Chickens(OviparousMixin,Animals):
	def __init__(self,name,weight,sound = 'Курлык',CountEggs=0):
		self.CountEggs=CountEggs;
		super().__init__(name,weight,sound)
	
class Goats(MilkMixin,Animals):
	def __init__(self,name,weight,sound = 'Бэ',CountMilk=0):
		self.CountMilk=CountMilk;
		super().__init__(name,weight,sound)

class Ducks(OviparousMixin,Animals):
	def __init__(self,name,weight,sound = 'Кря',CountEggs=0):
		self.CountEggs=CountEggs;
		super().__init__(name,weight,sound)

AnimalsInfo={};

Gray=Gooses('Серый',20)
print(Gray.__dict__)
AnimalsInfo[Gray.name]=Gray.weight
White=Gooses('Белый',18)
AnimalsInfo[White.name]=White.weight
print(White.__dict__)

Manku=Cows('Маньку',80)
AnimalsInfo[Manku.name]=Manku.weight
print(Manku.__dict__)

Lamb=Sheeps('Барашек',12)
print(Lamb.__dict__)
AnimalsInfo[Lamb.name]=Lamb.weight
Curly=Sheeps('Кудрявый',15)
AnimalsInfo[Curly.name]=Curly.weight
print(Curly.__dict__)

KoKo=Chickens('Ко-Ко',2)
AnimalsInfo[KoKo.name]=KoKo.weight
print(KoKo.__dict__)
Kukareku=Chickens('Кукареку',1.5)
AnimalsInfo[Kukareku.name]=Kukareku.weight
print(Kukareku.__dict__)

Horns=Goats('Рога',10)
AnimalsInfo[Horns.name]=Horns.weight
print(Horns.__dict__)
Hooves=Goats('Копыта',12)
AnimalsInfo[Hooves.name]=Hooves.weight
print(Hooves.__dict__)

Mallard=Ducks('Кряква',4)
AnimalsInfo[Mallard.name]=Mallard.weight
print(Mallard.__dict__)

print ('\n')

SumWeight=0;
MaxWeight=0;
Dir={'Maнбку':80}
print(sys.getsizeof(SumWeight))
print(sys.getsizeof(Dir))

NameMax='';
for name,weight in AnimalsInfo.items():
	SumWeight=SumWeight+weight
	if MaxWeight<weight:
		MaxWeight=weight;
		NameMax=name;
print(NameMax)
print(SumWeight)

Gray.eat(10)
Manku.MilkCow(10)
Lamb.cut(10)
KoKo.collecting_eggs(10)

print(Gray.__dict__)
print(White.__dict__)
print(Manku.__dict__)
print(Lamb.__dict__)
print(Curly.__dict__)
print(KoKo.__dict__)
print(Kukareku.__dict__)
print(Horns.__dict__)
print(Hooves.__dict__)
print(Mallard.__dict__)