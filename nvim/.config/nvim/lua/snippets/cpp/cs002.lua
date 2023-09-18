local ls = require("luasnip")
local i = ls.insert_node
local s = ls.snippet
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta

local headers = {
	lab = [[
	/*********************************************************
	 * AUTHOR 			: Eli Griffiths
	 * Lab #[]          : []
	 * CLASS 			: CS 002
	 * SECTION 			: Asynchronous
	 * Due Date 		: []
	 *********************************************************/
	]],
	assignment = [[
	/*********************************************************
	 * AUTHOR 			: Eli Griffiths
	 * Assignment #[]   : []
	 * CLASS 			: CS 002
	 * SECTION 			: Asynchronous
	 * Due Date 		: []
	 *********************************************************/
	]],
}

return {
	s(
		"h_assignment",
		fmta(headers.assignment .. [[
	#include <iostream>
	using namespace std;
	/*********************************************************
	 *
	 * []
	 *
	 * ________________________________________________________
	 *
	 * []
	 *
	 * ________________________________________________________
	 * INPUT:
	 * 
	 * OUTPUT:
	 *
	 *********************************************************/

	 int main()
	 {
		 // OUTPUT - Class header information
  		 cout << "*****************************************\n";
  		 cout << " Programmed by  : Eli Griffiths\n";
  		 cout << " Student ID     : 10680823\n";
  		 cout << " CS002          : Asynchronous\n";
  		 cout << " Assignment #[] : []\n";
  		 cout << "*****************************************\n";
  		 cout << "\n";
	 }
	]], { i(1), i(2), i(3), rep(2), i(0), rep(1), rep(2) }, { delimiters = "[]" })
	),
	s(
		"h_lab",
		fmta(headers.lab .. [[
	#include <iostream>
	using namespace std;
	/*********************************************************
	 *
	 * []
	 *
	 * ________________________________________________________
	 *
	 * []
	 *
	 * ________________________________________________________
	 * INPUT:
	 * 
	 * OUTPUT:
	 *
	 *********************************************************/

	 int main()
	 {
		 // OUTPUT - Class header information
  		 cout << "*****************************************\n";
  		 cout << " Programmed by  : Eli Griffiths\n";
  		 cout << " Student ID     : 10680823\n";
  		 cout << " CS002          : Asynchronous\n";
  		 cout << " Assignment #[] : []\n";
  		 cout << "*****************************************\n";
  		 cout << "\n";
	 }
	]], { i(1), i(2), i(3), rep(2), i(0), rep(1), rep(2) }, { delimiters = "[]" })
	),
}
