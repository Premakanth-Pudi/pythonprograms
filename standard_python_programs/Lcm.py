n1=(int(input("Enter the Number 1: ")))
n2=(int(input("Enter the Number 2: ")))
lcm=0
for i in range(1,n1*n2+1):
    if (i%n1==0) and (i%n2==0):
        lcm=i
        break
print(lcm)
