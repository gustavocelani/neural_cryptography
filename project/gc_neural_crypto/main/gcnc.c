
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
 * Creation Date: 18/09/2018
 * Creation Time: 13:54:28
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

/* GC Neural Cryptography Custom Includes */
#include "../includes/gcnc_prototypes.h"

/* Debug Flag */
unsigned int DEBUG = 0;

/*
 * Main Loop
 *
 * Passing all parameters: ./gcnc.o <N> <K> <L> <act_func [0,1,2,3]> <learning_rule [0,1,2]> <debug [0,1]> <num_of_keys>
 */
int main(int argc, char *argv[])
{
	/* Default Values */
	unsigned int n     = 64;
	unsigned int k     = 1;
	unsigned int l     = 2;
	activation_function_t act_func = ACT_FUNC_SGN;
	learning_rule_t learning_rule  = LEARNING_RULE_ANTI_HEBBIAN;

	/* Generation Parameters */
	unsigned int number_of_keys = 1;
	unsigned int keys_count     = 0;

	if(argc == 8) //All Parameters
	{
		n = atoi(argv[1]); //N parameter
		k = atoi(argv[2]); //K parameter
		l = atoi(argv[3]); //L parameter

		switch(atoi(argv[4])) //Activation Function Parameter
		{
			case 0:
				act_func = ACT_FUNC_SGN;
				break;
			case 1:
				act_func = ACT_FUNC_LINEAR;
				break;
			case 2:
				act_func = ACT_FUNC_SIGMOID;
				break;
			case 3:
				act_func = ACT_FUNC_TANH;
				break;
			default:
				act_func = ACT_FUNC_SGN;
				break;
		}

		switch(atoi(argv[5])) //Learning Rule Parameter
		{
			case 0:
				learning_rule = LEARNING_RULE_HEBBIAN;
				break;
			case 1:
				learning_rule = LEARNING_RULE_ANTI_HEBBIAN;
				break;
			case 2:
				learning_rule = LEARNING_RULE_RANDOM_WALK;
				break;
			default:
				learning_rule = LEARNING_RULE_HEBBIAN;
				break;
		}

		if(atoi(argv[6]) > 0) { //Debug Level Parameter
			DEBUG = 1;
		} else {
			DEBUG = 0;
		}

		if(atoi(argv[7]) > 0) { //Number of Keys
			number_of_keys = atoi(argv[7]);
		}
	}
	else
	{
		printf("\nUsage:\n");
		printf("./gcnc.o <N> <K> <L> <act_func [0,1,2,3]> <learning_rule [0,1,2]> <debug [0,1]> <num_of_keys>\n\n");
		return EXIT_FAILURE;
	}

	// Updating Pseudo-Random Generator Seed
	// math_start_pseudo_random_generator(962611861);
	math_start_pseudo_random_generator(0);

	for(keys_count = 0; keys_count < number_of_keys; keys_count++) {

		printf("Generating Key [ %5d ]\n", keys_count+1);

		if(!neural_cryptography_init(k, n, l, act_func, learning_rule)) {
			printf("Neural cryptography initialization fatal error...\n");
			return EXIT_FAILURE;
		}

		if(!neural_cryptography_start()) {
			printf("Neural cryptography fatal error...\n");
			neural_cryptography_destroy();
			return EXIT_FAILURE;
		}

		neural_cryptography_destroy();
	}

	return EXIT_SUCCESS;
}

/*
 * Return if debug is on
 */
unsigned int is_debug(void) {
	return DEBUG;
}

