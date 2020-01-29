
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
 * Creation Date: 23/09/2018
 * Creation Time: 22:41:34
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

#ifndef GCNC_PROTOTYPES_H
#define GCNC_PROTOTYPES_H

/* General Includes */
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <string.h>

/* GC Neural Cryptography Definitions */
#include "gcnc_definitions.h"

/******** Tree Parity Machine Functinos Prototypes ********/

signed int tree_parity_machine_train(	tree_parity_machine_t *tree_parity_machine,
										signed int *input_array);

void tree_parity_machine_learn(	tree_parity_machine_t *tree_parity_machine,
								signed int *input_array,
								signed int *outputs);

void tree_parity_machine_hebbian_learning_rule(	tree_parity_machine_t *tree_parity_machine,
												signed int *input_array,
												signed int *outputs);

void tree_parity_machine_anti_hebbian_learning_rule(tree_parity_machine_t *tree_parity_machine,
													signed int *input_array,
													signed int *outputs);

void tree_parity_machine_random_walk_learning_rule(	tree_parity_machine_t *tree_parity_machine,
													signed int *input_array,
													signed int *outputs);

unsigned int tree_parity_machine_match_sinaptic_weights(tree_parity_machine_t *tree_parity_machine_A,
														tree_parity_machine_t *tree_parity_machine_B);

void learning_rule_to_string(learning_rule_t learning_rule, char *learning_rule_str);
void tree_parity_machine_destroy(tree_parity_machine_t *tree_parity_machine);
void tree_parity_machine_print(tree_parity_machine_t *tree_parity_machine);
void input_array_print(signed int *input_array, unsigned int size);
void tree_parity_machine_print_training_epoch(tree_parity_machine_t *tree_parity_machine, signed int *input_array);
void input_array_destroy(signed int *input_array);
char* tree_parity_machine_get_key(tree_parity_machine_t *tree_parity_machine);

unsigned int tree_parity_machine_generate_result_files(	tree_parity_machine_t *tree_parity_machine_A,
														tree_parity_machine_t *tree_parity_machine_B,
														long total_time);

tree_parity_machine_t* tree_parity_machine_init(unsigned int id,
												unsigned int k,
												unsigned int n,
												unsigned int l,
												activation_function_t act_func,
												learning_rule_t learning_rule);


/******** Neuron Functions Prototypes ********/

void neuron_destroy(neuron_t *neuron, unsigned int k);
void neuron_print_all(neuron_t *neuron, unsigned int k);
void neuron_print_single(neuron_t *neuron, unsigned int i);
void neuron_calculate_output(signed int activation_potential, neuron_t *hidden_neurons, unsigned int position);
neuron_t* neuron_init(  unsigned int k,
						unsigned int n,
						unsigned int l,
						activation_function_t act_func);


/******** Neural Cryptography Functions Prototypes ********/

unsigned int neural_cryptography_start(void);
void neural_cryptography_destroy(void);
unsigned int neural_cryptography_init(  unsigned int k,
										unsigned int n,
										unsigned int l,
										activation_function_t act_func,
										learning_rule_t learning_rule );


/******** Mathematics Function Prototypes ********/

void math_start_pseudo_random_generator(double seed);
signed int math_generate_random_number(unsigned int range);
signed int *math_generate_input_array(unsigned int size, unsigned int n);
void math_activation_function_to_string(activation_function_t act_func, char *act_func_str);
float math_signal_function(float input);
float math_linear_function(float input);
float math_sigmoid_function(float input);
float math_tanh_function(float input);


/******** GCNC Function Prototypes ********/

unsigned int is_debug(void);

#endif

