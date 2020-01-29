
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
 * Creation Date: 24/09/2018
 * Creation Time: 20:56:51
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
#include <sys/time.h>

/* Global Vairables */
tree_parity_machine_t *tree_parity_machine_A;
tree_parity_machine_t *tree_parity_machine_B;

/* Time Control */
struct timeval start_time;
struct timeval stop_time;

/*
 * Initializating elements of neural cryptography
 */
unsigned int neural_cryptography_init(  unsigned int k,
										unsigned int n,
										unsigned int l,
										activation_function_t act_func,
										learning_rule_t learning_rule )
{
	gettimeofday(&start_time, NULL);

	if(is_debug())
		printf("Initializing time counting (%ld)\n\n", start_time.tv_usec);

	if(is_debug())
		printf("Attempt to initialize tree parity machine A\n");

	tree_parity_machine_A = tree_parity_machine_init(TREE_PARITY_MACHINE_A, k, n, l, act_func, learning_rule);
	if(tree_parity_machine_A == NULL) {
		printf("ERROR: Fail to initialize tree parity machine A\n");
		return 0;
	}

	if(is_debug()) {
		printf("Tree parity machine A initialized successfully\n");
		printf("Attempt to initialize tree parity machine B\n");
	}

	tree_parity_machine_B = tree_parity_machine_init(TREE_PARITY_MACHINE_B, k, n, l, act_func, learning_rule);
	if(tree_parity_machine_B == NULL) {
		printf("ERROR: Fail to initialize tree parity machine B\n");
		return 0;
	}

	if(is_debug()) {
		printf("Tree parity machine B initialized successfully\n");
		printf("Neural cryptography initialized successfully\n");
	}

	return 1;
}

/*
 * Training Method
 *
 * -> Generate Input array
 * -> Run the same input array on both tree parity machines
 * -> Match the output
 * -> Fix sinaptic weights if they're equals
 * -> Stop when both sinaptic weights array were the same
 */
unsigned int neural_cryptography_start(void)
{
	unsigned int syncronized = 0; //Syncronization flag
	signed int *input_array;      //Input Array for both tree parity machines
	signed int *outputs;          //Tree parity machine's outputs
	long total_time;              //Total Generation Time

	outputs = malloc(2 * sizeof(signed int));
	if(outputs == NULL) {
		printf("ERROR: Fail to allocate memory to tree parity machine's outputs\n");
		return 0;
	}

	while(!syncronized)
	{
		input_array = math_generate_input_array(tree_parity_machine_A->num_of_inputs, tree_parity_machine_A->n);
		if(input_array == NULL) {
			printf("ERROR: Fail to generate input array\n");
			return 0;
		}

		if(is_debug()) {
			input_array_print(input_array, tree_parity_machine_A->num_of_inputs);
			printf("\n");
		}

		outputs[TREE_PARITY_MACHINE_A] = tree_parity_machine_train(tree_parity_machine_A, input_array);
		outputs[TREE_PARITY_MACHINE_B] = tree_parity_machine_train(tree_parity_machine_B, input_array);

		if(tree_parity_machine_A->output != tree_parity_machine_B->output) {
			if(is_debug()) {
				printf("############################## Unmatch Outputs ################################\n");
				printf("############################## Training Again  ################################\n");
			}

			continue;
		}
		else if(is_debug()) {
				printf("############################### Match Outputs #################################\n");
				printf("########################## Appling Learning Rule ##############################\n\n");
		}

		tree_parity_machine_learn(tree_parity_machine_A, input_array, outputs);
		tree_parity_machine_learn(tree_parity_machine_B, input_array, outputs);

		if(tree_parity_machine_match_sinaptic_weights(tree_parity_machine_A, tree_parity_machine_B)) {
			syncronized = 1;
		} else if(is_debug()){
			printf("###############################################################################\n");
		}
	}

	free(outputs);

	if(is_debug())
		printf("Tree Parity Machines Syncronization Success!\n");

	gettimeofday(&stop_time, NULL);
	total_time = (((stop_time.tv_sec - start_time.tv_sec) * 1000000) + stop_time.tv_usec) - (start_time.tv_usec);

	if(is_debug()) {
		printf("Stopping time count (%ld)\n", stop_time.tv_usec);
		printf("Total Time = %ld\n\n", total_time);
	}

	tree_parity_machine_generate_result_files(tree_parity_machine_A, tree_parity_machine_B, total_time);

	return 1;
}

/*
 * Destroy all elementes used on neural cryptography
 */
void neural_cryptography_destroy(void)
{
	if(is_debug())
		printf("Free tree parity machine A\n");

	tree_parity_machine_destroy(tree_parity_machine_A);

	if(is_debug())
		printf("Free tree parity machine B\n");

	tree_parity_machine_destroy(tree_parity_machine_B);

	if(is_debug())
		printf("Free completed successfully\n");

	return;
}

