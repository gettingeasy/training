#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include"/home/wenhsuan/repo/library/ticket.h"

#define STOP_MAX 5
#define SEAT_MAX 6

void init_seat(struct trip ** seat, int * flag)
{
 struct trip *new_seat, *last_seat;
 int i, j;
 for(i=0;i<SEAT_MAX;i++){
	flag[i]=1;
	for(j=0;j<STOP_MAX;j++){
		new_seat=(struct trip*)malloc(sizeof(struct trip));
		new_seat->booked=0;
		if(seat[i]==NULL){
			seat[i]=new_seat;
			last_seat=new_seat;
			}
		else
			{
			last_seat->next=new_seat;
			last_seat=new_seat;
			
			}
		}
	}
}

int main(void)
{
 
 int book, book_tmp, de, ar;
 int i;
 char *yn = NULL;
 struct trip *seat[SEAT_MAX];
 int flag[SEAT_MAX];

 yn=malloc(sizeof(char));
 memset(seat, 0x00, sizeof(seat));
 init_seat(seat,flag);
 
 printf("would you like to book tickets? ");
 scanf("%s", yn);
 while(!(strcmp(yn,"y")))
 {
	printf("from which station: 1.taipei 2.hsichu 3.taichung 4.tainan 5.kuochiang ");
	scanf("%d", &de);
	printf("to which station: 1.taipei 2.hsichu 3.taichung 4.tainan 5.kuochiang ");
	scanf("%d", &ar);
 	printf("how many seats do you want to book?");
 	scanf("%d", &book);
	book_tmp=book;
 	ar-=1;
	de-=1;
	int empty=0;
	for(i=0;i<SEAT_MAX;i++){
		flag[i]=1;
        	if(check(seat[i],de,ar))
			printf("empty=%d",empty++);
		else
			printf("i=%d, %d\n", i, flag[i]=0);
	}
	if(empty>=book_tmp){
		for(i=0;i<SEAT_MAX;i++)
			if(flag[i] == 1 && book_tmp>0){
           			reserve(seat[i],de,ar);
				printf("i=%d, %d\n", i, book_tmp--);
			}
			else continue;
		printf("you have booked %d tickets!", book);
		}
	else {  printf("not enough seats within these stops\n");
	        printf("would you like to book tickets? ");
		}
 printf("do you want to continue? ");
 scanf("%s", yn);
	
 }
 return 0;
}
