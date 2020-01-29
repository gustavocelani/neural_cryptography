
/********************************************************************************
 *          ____________            _   __________  ______  ___    __
 *         / ____/ ____/           / | / / ____/ / / / __ \/   |  / /
 *        / / __/ /      ______   /  |/ / __/ / / / / /_/ / /| | / /
 *       / /_/ / /___   /_____/  / /|  / /___/ /_/ / _, _/ ___ |/ /___
 *       \____/\____/           /_/ |_/_____/\____/_/ |_/_/  |_/_____/
 *    ____________  ______  __________  __________  ___    ____  __  ____  __
 *   / ____/ __ \ \/ / __ \/_  __/ __ \/ ____/ __ \/   |  / __ \/ / / /\ \/ /
 *  / /   / /_/ /\  / /_/ / / / / / / / / __/ /_/ / /| | / /_/ / /_/ /  \  /
 * / /___/ _, _/ / / ____/ / / / /_/ / /_/ / _, _/ ___ |/ ____/ __  /   / /
 * \____/_/ |_| /_/_/     /_/  \____/\____/_/ |_/_/  |_/_/   /_/ /_/   /_/
 *
 ********************************************************************************
 *              Copyright (C) Gustavo Celani - All Rights Reserved
 *    Written by Gustavo Celani <gustavo_celani@hotmail.com>, September 2018
 ********************************************************************************
 * Creation Date: 19/09/2018
 * Creation Time: 09:46:55
 *
 * Version:  1.0
 * Compiler: gcc
 *
 * Author:   Gustavo Pasqua de Oliveira Celani
 * Social:   GC - Gustavo Celani (@gustavo_celani)
 * Email:    gustavo_celani@hotmail.com
 * Linkedin: https://br.linkedin.com/in/gustavocelani
 *
 * Project Available on: https://github.com/gustavocelani/TCC_ANNCKG_Project.git
 * Article Available on: https://github.com/gustavocelani/TCC_ANNCKG_Article.git
 *******************************************************************************/

/*  General Includes */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Binary to Decimal
 */
int binary_to_decimal(char *binary)
{
	int i       = 0;
	int decimal = 0;
	int mul     = 0;

	for(decimal = 0, i = strlen(binary) - 1; i >= 0; --i, ++mul) {
		decimal += (binary[i] - 48) * (1 << mul);
	}

	return decimal;
}

/*
 * Print Hexadecimal Digit
 */
void print_hex_digit(int d)
{
	if(d < 10)       printf("%d", d);
	else if(d == 10) printf("A");
	else if(d == 11) printf("B");
	else if(d == 12) printf("C");
	else if(d == 13) printf("D");
	else if(d == 14) printf("E");
	else if(d == 15) printf("F");
}

/*
 * Return Hexadecimal Digit
 */
char return_hex_digit(int d)
{
	char hexa;

	switch(d)
	{
		case 0:
			hexa = '0';
			break;
		case 1:
			hexa = '1';
			break;
		case 2:
			hexa = '2';
			break;
		case 3:
			hexa = '3';
			break;
		case 4:
			hexa = '4';
			break;
		case 5:
			hexa = '5';
			break;
		case 6:
			hexa = '6';
			break;
		case 7:
			hexa = '7';
			break;
		case 8:
			hexa = '8';
			break;
		case 9:
			hexa = '9';
			break;
		case 10:
			hexa = 'A';
			break;
		case 11:
			hexa = 'B';
			break;
		case 12:
			hexa = 'C';
			break;
		case 13:
			hexa = 'D';
			break;
		case 14:
			hexa = 'E';
			break;
		case 15:
			hexa = 'F';
			break;
		default:
			hexa = '0';
			break;
	}

	return hexa;
}


/*
 * Converts a binary number into a hexadecimal number
 */
unsigned int binary_to_hexadecimal(char *binary, char *hexadecimal)
{
	char aux[5];
	unsigned int i     = 0;
	unsigned int j     = 0;
	unsigned int d     = 0;
	unsigned int count = 0;

	for(i = j = 0; i < strlen(binary) % 4; ++i, ++j) {
		aux[j] = binary[i];
	}
	aux[j] = '\0';

	d = binary_to_decimal(aux);
	if(d != 0) hexadecimal[count++] = return_hex_digit(d);

	while(binary[i] != '\0')
	{
		for(j = 0; j < 4; ++i, ++j) {
			aux[j] = binary[i];
		}
		aux[j] = '\0';

		d = binary_to_decimal(aux);
		hexadecimal[count++] = return_hex_digit(d);
	}

	hexadecimal[count] = '\0';
	return strlen(hexadecimal);
}

/*
 * Add an string to ../outputs/keys_hex.txt
 */
unsigned int add_to_file(char *hexadecimal)
{
	FILE *keys_hex_file;

	keys_hex_file = fopen("../outputs/keys_hex.txt", "a");
	if(keys_hex_file) {
		fputs(hexadecimal, keys_hex_file);
		fputs("\n", keys_hex_file);
		fclose(keys_hex_file);
		return 1;
	}

	return 0;
}

/*
 * Main loop
 */
int main(int argc, char *argv[])
{
	if(argc != 2) {
		printf("\nUsage:\n");
		printf("./bin_to_hex.o <binary number>\n\n");
		return EXIT_FAILURE;
	}

	char *binary = argv[1];
	char *hexadecimal;

	hexadecimal = malloc(strlen(binary) * sizeof(char));
	if(hexadecimal == NULL) {
		printf("\nBinary to Hexadecimal Malloc Fatal Error...\n");
		printf("./bin_to_hex.o <binary number>\n\n");
		return EXIT_FAILURE;
	}

	if(binary_to_hexadecimal(binary, hexadecimal) <= 0) {
		printf("\nBinary to Hexadecimal Convert Fatal Error...\n");
		printf("./bin_to_hex.o <binary number>\n\n");
		return EXIT_FAILURE;
	}

	if(add_to_file(hexadecimal) <= 0) {
		printf("\nBinary to Hexadecimal Write Fatal Error...\n");
		printf("./bin_to_hex.o <binary number>\n\n");
		return EXIT_FAILURE;
	}

	// printf("Binary..... %s\n", binary);
	// printf("Hexa....... %s\n\n", hexadecimal);
	return EXIT_SUCCESS;
}

