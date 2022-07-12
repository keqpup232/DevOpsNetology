import sentry_sdk

sentry_sdk.init(
    dsn="*",
    traces_sample_rate=1.0
)

while True:
    num = input('Enter error number: ')
    if num == '1':
        division_by_zero = 1 / 0
    elif num == '2':
        print(x)
    elif num == '3':
        f = open("demofile.txt")
        f.write("Lorum Ipsum")
        f.close()
    elif num == '4':
        geeky_list = ["Geeky", "GeeksforGeeks", "SuperGeek", "Geek"]
        indices = [0, 1, "2", 3]
        for i in range(len(indices)):
            print(geeky_list[indices[i]])
    elif num == 'q':
        quit()