#include<stdio.h>
int func(int s)
int main()
{
	int s;
	printf("请输入一个整数:");
	scanf("%d"&s);
	sum = func(s);
	printf("%d! = %d",s,sum);
	return 0;
}
func(int s)
{
	int num;
	if s == 1:
		return 1;
	else:{
		num = func(s - 1) * s;
		return s;
	      }
