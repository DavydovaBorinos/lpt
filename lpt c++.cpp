#include <conio.h>
#include <windows.h>
#include <iostream>
#include <stdio.h>
#include <string>
#include <ctype.h>
using namespace std;
int main ()
{
HANDLE hLPT = CreateFile ( "LPT1" , GENERIC_WRITE , 0 , NULL , OPEN_EXISTING , FILE_ATTRIBUTE_NORMAL , NULL );
if ( hLPT != INVALID_HANDLE_VALUE )
{
cout << "YOUR TEXT\n\n";
DWORD a;
char b;
b = getch();
cout << b;
if ( b == 0x0d ) cout << endl;
WriteFile ( hLPT , &b, 1, &a, NULL );
while ( b != 0x1B )
{
b = getch ();
cout << b;
if ( b == 0x0d ) cout << endl;
WriteFile( hLPT , &b , 1 , &a , NULL );
}

b = 0x0d;
WriteFile ( hLPT , &b , 1 , &a , NULL );
CloseHandle ( hLPT );
}

else cout << "ERROR!!!\n\n";
return 0;
}
