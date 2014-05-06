#include<stdio.h>
#include "ticket.h"

void reserve(struct trip * seat, int depart, int arrival)
{
 int i, j;
 for(i=0;i<depart;i++)
	seat=seat->next;
 for(j=0;j<=(arrival-depart);j++)
	if(seat->next!=NULL){
		seat->booked=1;
		seat=seat->next;
	}
}

