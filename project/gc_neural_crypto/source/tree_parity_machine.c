
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
 * Creation Time: 20:11:08
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

/*
 * Initialize Tree Parity Machine
 *
 * id            -> Identification
 * k             -> Number of neurons in hidden layer
 * n             -> number of input for each neuron
 * l             -> Sinaptic Weights Range ( w in [-w_range, +w_range] )
 * act_func      -> Neuron's Activation Function
 * learning_rule -> Neural Network's learning rule
 */
tree_parity_machine_t* tree_parity_machine_init(unsigned int id,
												unsigned int k,
												unsigned int n,
												unsigned int l,
												activation_function_t act_func,
												learning_rule_t learning_rule)
{
	unsigned int i=0;
	neuron_t *neurons;
	tree_parity_machine_t *tree_parity_machine;
	char learning_rule_str[64];

	tree_parity_machine = malloc(1 * sizeof(tree_parity_machine_t));
	if(tree_parity_machine == NULL) {
		printf("ERROR: Fail to allocate tree parity machine's memory\n");
		return NULL;
	}

	if(is_debug()) {
		learning_rule_to_string(learning_rule, learning_rule_str);

		printf("\nInitializing tree parity machine's parameters\n");
		printf("Setting tree parity machine's ID to %d\n", id);
		printf("Setting tree parity machine's K to  %d\n", k);
		printf("Setting tree parity machine's N to  %d\n", n);
		printf("Setting tree parity machine's L to  %d\n", l);
		printf("Setting tree parity machine's number of inputs to %d\n", (k*n));
		printf("Setting tree parity machine's training epochs to 0\n");
		printf("Setting tree parity machine's learning rule to %s\n", learning_rule_str);
		printf("Setting tree parity machine's output to 0\n");
	}

	tree_parity_machine->id            = id;
	tree_parity_machine->k             = k;
	tree_parity_machine->n             = n;
	tree_parity_machine->l             = l;
	tree_parity_machine->num_of_inputs = (k*n) + k; //Including one BIAS value for each hidden neuron
	tree_parity_machine->epochs        = 0;
	tree_parity_machine->learning_rule = learning_rule;
	tree_parity_machine->output        = 0;

	tree_parity_machine->hidden_neurons = neuron_init(k, n, l, act_func);
	if(tree_parity_machine->hidden_neurons == NULL) {
		printf("Fail on initialize tree parity machine neurons array\n");
		return NULL;
	}

	//if(is_debug())
	//	neuron_print_all(tree_parity_machine->hidden_neurons, tree_parity_machine->k);

	if(is_debug())
		tree_parity_machine_print(tree_parity_machine);

	return tree_parity_machine;
}

/*
 * Training Function
 * Calculates tree parity machine's output
 */
signed int tree_parity_machine_train(tree_parity_machine_t *tree_parity_machine, signed int *input_array)
{
	unsigned int k_count            = 0; //Hidden Neurons Count
	unsigned int n_count            = 0; //Inputs for each Neuron Count
	unsigned int i_count            = 0; //Input Array Count
	signed int activation_potential = 0; //Activation Potential
	signed int output               = 1; //Tree Parity Machine's output

	if(is_debug())
		tree_parity_machine_print_training_epoch(tree_parity_machine, input_array);

	for(k_count = 0; k_count < tree_parity_machine->k; k_count++) {

		activation_potential = 0;

		for(n_count = 0; n_count < tree_parity_machine->n+1; n_count++) {
			activation_potential += input_array[i_count++] * tree_parity_machine->hidden_neurons[k_count].sinaptic_weights[n_count];
		}

		if(is_debug())
			printf("\nActivation Potential of neuron [ %d ] is [ %d ]\n", k_count, activation_potential);

		neuron_calculate_output(activation_potential, tree_parity_machine->hidden_neurons, k_count);

		if(is_debug())
			printf("Output of neuron [ %d ] is [ %f ]\n", k_count, tree_parity_machine->hidden_neurons[k_count].output);

		output = output * tree_parity_machine->hidden_neurons[k_count].output;
	}

	if(is_debug()) {
		if(tree_parity_machine->id == TREE_PARITY_MACHINE_A)
			printf("\nTree parity machine A output [ %d ]\n", output);
		else if(tree_parity_machine->id == TREE_PARITY_MACHINE_B)
			printf("\nTree parity machine B output [ %d ]\n", output);
	}

	tree_parity_machine->output = output;
	tree_parity_machine->epochs++;

	if(is_debug()) {
		if(tree_parity_machine->id == TREE_PARITY_MACHINE_A)
			printf("Tree parity machine A epoch updated to [ %d ]\n\n", tree_parity_machine->epochs);
		else if(tree_parity_machine->id == TREE_PARITY_MACHINE_B)
			printf("Tree parity machine B epoch updated to [ %d ]\n\n", tree_parity_machine->epochs);
	}

	return output;
}

/*
 * Apply Learning Rule
 */
void tree_parity_machine_learn(tree_parity_machine_t *tree_parity_machine, signed int *input_array, signed int *outputs)
{
	char learning_rule_str[64];
	learning_rule_to_string(tree_parity_machine->learning_rule, learning_rule_str);

	if(is_debug()) {
		if(tree_parity_machine->id == TREE_PARITY_MACHINE_A)
			printf("Applying %s's Learning Rule on Tree Parity Machine A\n", learning_rule_str);
		else if(tree_parity_machine->id == TREE_PARITY_MACHINE_B)
			printf("Applying %s's Learning Rule on Tree Parity Machine B\n", learning_rule_str);
	}

	switch(tree_parity_machine->learning_rule)
	{
		case LEARNING_RULE_HEBBIAN:
			tree_parity_machine_hebbian_learning_rule(tree_parity_machine, input_array, outputs);
			break;
		case LEARNING_RULE_ANTI_HEBBIAN:
			tree_parity_machine_anti_hebbian_learning_rule(tree_parity_machine, input_array, outputs);
			break;
		case LEARNING_RULE_RANDOM_WALK:
			tree_parity_machine_random_walk_learning_rule(tree_parity_machine, input_array, outputs);
			break;
		default:
			tree_parity_machine_hebbian_learning_rule(tree_parity_machine, input_array, outputs);
			break;
	}

	return;
}

/*
 * Hebbian learning rule
 */
void tree_parity_machine_hebbian_learning_rule(tree_parity_machine_t *tree_parity_machine, signed int *input_array, signed int *outputs)
{
	unsigned int k_count = 0;               //Hidden neurons count
	unsigned int n_count = 0;               //Sinaptic weights count
	unsigned int i_count = 0;               //Input array count
	signed int current_sinaptic_weight = 0; //Sinaptic Weight before learn rule
	signed int new_sinaptic_weight     = 0; //Sinaptic Weight after learn rule

	for(k_count = 0; k_count < tree_parity_machine->k; k_count++) {

		for(n_count = 0; n_count < tree_parity_machine->n+1; n_count++) {
			current_sinaptic_weight = tree_parity_machine->hidden_neurons[k_count].sinaptic_weights[n_count];

			new_sinaptic_weight =
				tree_parity_machine->hidden_neurons[k_count].sinaptic_weights[n_count] +
				input_array[i_count++] *
				tree_parity_machine->output *
				math_signal_function( tree_parity_machine->output * tree_parity_machine->hidden_neurons[k_count].output ) *
				math_signal_function( outputs[TREE_PARITY_MACHINE_A] * outputs[TREE_PARITY_MACHINE_B] );

			if(new_sinaptic_weight >= tree_parity_machine->l) {
				new_sinaptic_weight = tree_parity_machine->l;
			}
			else if(new_sinaptic_weight <= -tree_parity_machine->l) {
				new_sinaptic_weight = -tree_parity_machine->l;
			}

			tree_parity_machine->hidden_neurons[k_count].sinaptic_weights[n_count] = new_sinaptic_weight;

			if(is_debug())
				printf("Sinaptic Weight [%3d,%3d] updated [ %5d   to  %5d ]\n",
						k_count, n_count, current_sinaptic_weight, new_sinaptic_weight);

		}
	}

	if(is_debug()) {
		if(tree_parity_machine->id == TREE_PARITY_MACHINE_A)
			printf("Hebbian Learning Rule was applied on Tree Parity Machine A\n\n");
		else if(tree_parity_machine->id == TREE_PARITY_MACHINE_B)
			printf("Hebbian Learning Rule was applied on Tree Parity Machine B\n\n");
	}

	return;
}

/*
 * Anti Hebbian learning rule
 */
void tree_parity_machine_anti_hebbian_learning_rule(tree_parity_machine_t *tree_parity_machine, signed int *input_array, signed int *outputs)
{
	unsigned int k_count = 0;               //Hidden neurons count
	unsigned int n_count = 0;               //Sinaptic weights count
	unsigned int i_count = 0;               //Input array count
	signed int current_sinaptic_weight = 0; //Sinaptic Weight before learn rule
	signed int new_sinaptic_weight     = 0; //Sinaptic Weight after learn rule

	for(k_count = 0; k_count < tree_parity_machine->k; k_count++) {

		for(n_count = 0; n_count < tree_parity_machine->n+1; n_count++) {
			current_sinaptic_weight = tree_parity_machine->hidden_neurons[k_count].sinaptic_weights[n_count];

			new_sinaptic_weight =
				tree_parity_machine->hidden_neurons[k_count].sinaptic_weights[n_count] -
				input_array[i_count++] *
				tree_parity_machine->hidden_neurons[k_count].output *
				math_signal_function( tree_parity_machine->output * tree_parity_machine->hidden_neurons[k_count].output ) *
				math_signal_function( outputs[TREE_PARITY_MACHINE_A] * outputs[TREE_PARITY_MACHINE_B] );

			if(new_sinaptic_weight >= tree_parity_machine->l) {
				new_sinaptic_weight = tree_parity_machine->l;
			}
			else if(new_sinaptic_weight <= -tree_parity_machine->l) {
				new_sinaptic_weight = -tree_parity_machine->l;
			}

			tree_parity_machine->hidden_neurons[k_count].sinaptic_weights[n_count] = new_sinaptic_weight;

			if(is_debug())
				printf("Sinaptic Weight [%3d,%3d] updated [ %5d   to  %5d ]\n", k_count, n_count, current_sinaptic_weight, new_sinaptic_weight);
		}
	}

	if(is_debug()) {
		if(tree_parity_machine->id == TREE_PARITY_MACHINE_A)
			printf("Anti Hebbian Learning Rule was applied on Tree Parity Machine A\n\n");
		else if(tree_parity_machine->id == TREE_PARITY_MACHINE_B)
			printf("Anti Hebbian Learning Rule was applied on Tree Parity Machine B\n\n");
	}

	return;
}

/*
 * Random Walk learning rule
 */
void tree_parity_machine_random_walk_learning_rule(tree_parity_machine_t *tree_parity_machine, signed int *input_array, signed int *outputs)
{
	unsigned int k_count = 0;               //Hidden neurons count
	unsigned int n_count = 0;               //Sinaptic weights count
	unsigned int i_count = 0;               //Input array count
	signed int current_sinaptic_weight = 0; //Sinaptic Weight before learn rule
	signed int new_sinaptic_weight     = 0; //Sinaptic Weight after learn rule

	for(k_count = 0; k_count < tree_parity_machine->k; k_count++) {

		for(n_count = 0; n_count < tree_parity_machine->n+1; n_count++) {
			current_sinaptic_weight = tree_parity_machine->hidden_neurons[k_count].sinaptic_weights[n_count];

			new_sinaptic_weight =
				tree_parity_machine->hidden_neurons[k_count].sinaptic_weights[n_count] +
				input_array[i_count++] *
				math_signal_function( tree_parity_machine->output * tree_parity_machine->hidden_neurons[k_count].output ) *
				math_signal_function( outputs[TREE_PARITY_MACHINE_A] * outputs[TREE_PARITY_MACHINE_B] );

			if(new_sinaptic_weight >= tree_parity_machine->l) {
				new_sinaptic_weight = tree_parity_machine->l;
			}
			else if(new_sinaptic_weight <= -tree_parity_machine->l) {
				new_sinaptic_weight = -tree_parity_machine->l;
			}

			tree_parity_machine->hidden_neurons[k_count].sinaptic_weights[n_count] = new_sinaptic_weight;

			if(is_debug())
				printf("Sinaptic Weight [%3d,%3d] updated [ %5d   to  %5d ]\n", k_count, n_count, current_sinaptic_weight, new_sinaptic_weight);
		}
	}

	if(is_debug()) {
		if(tree_parity_machine->id == TREE_PARITY_MACHINE_A)
			printf("Random Walk Learning Rule applied on Tree Parity Machine A\n\n");
		else if(tree_parity_machine->id == TREE_PARITY_MACHINE_B)
			printf("Random Walk Learning Rule applied on Tree Parity Machine B\n\n");
	}

	return;
}

/*
 * Matches Sinaptic Weights Arrays
 */
unsigned int tree_parity_machine_match_sinaptic_weights(tree_parity_machine_t *tree_parity_machine_A,
														tree_parity_machine_t *tree_parity_machine_B)
{
	unsigned int k_count = 0; //Hidden neurons count
	unsigned int n_count = 0; //Sinaptic weights count

	for(k_count = 0; k_count < tree_parity_machine_A->k; k_count++) {
		for(n_count = 0; n_count < tree_parity_machine_A->n+1; n_count++) {

			if( tree_parity_machine_A->hidden_neurons[k_count].sinaptic_weights[n_count] !=
				tree_parity_machine_B->hidden_neurons[k_count].sinaptic_weights[n_count]) {
				return 0;
			}
		}
	}

	return 1;
}

/*
 * Generates Output Files
 */
unsigned int tree_parity_machine_generate_result_files( tree_parity_machine_t *tree_parity_machine_A,
														tree_parity_machine_t *tree_parity_machine_B,
														long total_time)
{
	FILE *key_file;
	char *key;
	FILE *epochs_file;
	char epochs[8];
	FILE *time_file;
	char total_time_str[128];

	if(is_debug())
		printf("Generating Result Files...\n");

	/* Binary Key File */
	key = tree_parity_machine_get_key(tree_parity_machine_A);
	if(key == NULL) {
		printf("ERROR: Fail on gets tree parity machine's key\n");
		return 0;
	}

	key_file = fopen("../outputs/keys_bin.txt", "a");
	if(key_file) {
		fputs(key, key_file);
		fputs("\n", key_file);
	}
	fclose(key_file);

	/* Number of Epochs File */
	sprintf(epochs, "%d", tree_parity_machine_A->epochs);
	epochs_file = fopen("../outputs/epochs.txt", "a");
	if(epochs_file) {
		fputs(epochs, epochs_file);
		fputs("\n", epochs_file);
	}
	fclose(epochs_file);

	/* Time File */
	sprintf(total_time_str, "%ld", total_time);
	time_file = fopen("../outputs/time.txt", "a");
	if(time_file) {
		fputs(total_time_str, time_file);
		fputs("\n", time_file);
	}
	fclose(time_file);

	if(is_debug())
		printf("Result Files Generated Successfully!\nIt's available on 'outputs' folder\n\n");

	return 1;
}

/*
 * Returns Key using sinaptic weights excluding BIAS for each hidden neuron
 */
char* tree_parity_machine_get_key(tree_parity_machine_t *tree_parity_machine)
{
	unsigned int k_count = 0;  //Hidden neurons count
	unsigned int n_count = 1;  //Sinaptic weights count excluding BIAS for each hidden neuron
	unsigned int i_count = 0;  //Input array count
	char *key;                 //Key Array

	key = malloc(tree_parity_machine->num_of_inputs * sizeof(char));
	if(key == NULL) {
		printf("ERROR: Fail to allocate key's memory\n");
		return NULL;
	}

	for(k_count = 0; k_count < tree_parity_machine->k; k_count++) {

		for(n_count = 1; n_count < tree_parity_machine->n+1; n_count++) {
			if(tree_parity_machine->hidden_neurons[k_count].sinaptic_weights[n_count] > 0) {
				*(key + i_count++) = '1';
			} else {
				*(key + i_count++) = '0';
			}
		}
	}

	//if(is_debug()) {
	//	if(tree_parity_machine->id == TREE_PARITY_MACHINE_A)
	//		printf("Tree Parity Machine A generated Key: %s\n", key);
	//	else if(tree_parity_machine->id == TREE_PARITY_MACHINE_B)
	//		printf("Tree Parity Machine B generated Key: %s\n", key);
	//}

	return key;
}

/*
 * Tree parity Machine Destroy
 */
void tree_parity_machine_destroy(tree_parity_machine_t *tree_parity_machine)
{
	if(is_debug())
		printf("Free hidden neurons\n");

	neuron_destroy(tree_parity_machine->hidden_neurons, tree_parity_machine->k);

	if(is_debug())
		printf("Free tree parity machine\n");

	free(tree_parity_machine);

	return;
}

/*
 * Print Tree parity machine on console
 */
void tree_parity_machine_print(tree_parity_machine_t *tree_parity_machine)
{
	char learning_rule_str[64];

	printf("\n");
	learning_rule_to_string(tree_parity_machine->learning_rule, learning_rule_str);

	printf("=================================================================================\n");
	printf("Tree Parity Machine\n");
	printf("=================================================================================\n");

	if(tree_parity_machine->id == TREE_PARITY_MACHINE_A)
		printf("ID               A\n");
	else if(tree_parity_machine->id == TREE_PARITY_MACHINE_B)
		printf("ID               B\n");

	printf("K                %d\n", tree_parity_machine->k);
	printf("N                %d\n", tree_parity_machine->n);
	printf("L                %d\n", tree_parity_machine->l);
	printf("Training Epochs  %d\n", tree_parity_machine->epochs);
	printf("Number of Inputs %d\n", tree_parity_machine->num_of_inputs);
	printf("Hidden Neurons   %d\n", tree_parity_machine->k);
	printf("Learning Rule    %s\n", learning_rule_str);
	printf("Last Output      %d\n", tree_parity_machine->output);
	printf("=================================================================================\n\n");
}

/*
 * Print Sinaptic Weights Array
 */
void tree_parity_machine_print_training_epoch(tree_parity_machine_t *tree_parity_machine, signed int *input_array)
{
	unsigned int k_count = 0; //Hidden neurons count
	unsigned int n_count = 0; //Sinaptic weights count
	unsigned int i_count = 0; //Input array count

	if(tree_parity_machine->id == TREE_PARITY_MACHINE_A)
		printf("Training Epoch [ %d ] of Tree Partity Machine A\n", tree_parity_machine->epochs);
	else if(tree_parity_machine->id == TREE_PARITY_MACHINE_B)
		printf("Training Epoch [ %d ] of Tree Partity Machine B\n", tree_parity_machine->epochs);

	for(k_count = 0; k_count < tree_parity_machine->k; k_count++) {

		for(n_count = 0; n_count < tree_parity_machine->n+1; n_count++) {

			printf("Input [ %2d ] -> Sinaptic Weight [ %6d ] -> Neuron [ %3d ]\n",
					input_array[i_count++],
					tree_parity_machine->hidden_neurons[k_count].sinaptic_weights[n_count],
					k_count);
		}
	}

	return;
}

/*
 * Learning Rule to String
 */
void learning_rule_to_string(learning_rule_t learning_rule, char *learning_rule_str)
{
	switch(learning_rule)
	{
		case LEARNING_RULE_HEBBIAN:
			sprintf(learning_rule_str, "Hebbian");
			break;
		case LEARNING_RULE_ANTI_HEBBIAN:
			sprintf(learning_rule_str, "Anti-Hebbian");
			break;
		case LEARNING_RULE_RANDOM_WALK:
			sprintf(learning_rule_str, "Random Walk");
			break;
		default:
			sprintf(learning_rule_str, "Hebbian");
			break;
	}
}

/*
 * Print Input Array
 */
void input_array_print(signed int *input_array, unsigned int size)
{
	unsigned int i = 0;

	printf("\n");
	printf("Input Array = [ ");

	for(i=0; i<size; i++) {
		printf("%d ", input_array[i]);
	}

	printf("]\n");
	return;
}

/*
 * Free input array
 */
void input_array_destroy(signed int *input_array)
{
	if(is_debug())
		printf("Free input array\n");

	free(input_array);
}

