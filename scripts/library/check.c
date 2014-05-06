#include<stdio.h>
#include "ticket.h"

int check(struct trip * seat, int depart, int arrival)
{
 struct trip * seat_tmp = seat;
 int i, j;

 for(i=0;i<depart;i++)
	seat_tmp=seat_tmp->next;
 for(j=0;j<=(arrival-depart);j++)
	if(seat_tmp->next!=NULL)
		if(seat_tmp->booked){
			return 0;
		}
		else
			seat_tmp=seat_tmp->next;
 return 1;
}

