
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

/* GC Neural Cryptography Custom Includes */
#include "../includes/gcnc_prototypes.h"

/*
 * Artificial Neuron Initializing
 *
 * k        -> Number of neurons to be initialized
 * n        -> Number of inputs for each neuron
 * l        -> Sinaptic Weights Range ( w in [-w_range, +w_range] )
 * act_func -> Activation Function
 */
neuron_t* neuron_init(  unsigned int k,
						unsigned int n,
						unsigned int l,
						activation_function_t act_func)
{
	unsigned int i=0; //Neurons number count
	unsigned int w=0; //Sinaptic weights count
	char act_func_str[64];

	neuron_t *neuron;
	neuron = malloc(k * sizeof(neuron_t));

	if(neuron == NULL) {
		printf("ERROR: Fail to allocate neuron's memory\n");
		return NULL;
	}

	for(i=0; i<k; i++)
	{
		if(is_debug()) {
			math_activation_function_to_string(neuron[i].activation_function, act_func_str);

			printf("\nInitializing neuron parameters\n");
			printf("Setting neuron id to %d\n", i);
			printf("Setting neuron number of inputs to %d\n", n);
			printf("Setting neuron number of sinaptic weights to %d\n", n+1);
			printf("Setting neuron sinaptic weights range to %d\n", l);
			printf("Allocating memory for neuron sinaptic weights\n");
			printf("Setting neuron activation function to %s\n", act_func_str);
			printf("Setting neuron output to 0\n");
		}

		neuron[i].id                  = i;
		neuron[i].num_of_inputs       = n + 1;
		neuron[i].num_of_weights      = n + 1;
		neuron[i].weights_range       = l;
		neuron[i].sinaptic_weights    = malloc(neuron->num_of_weights * sizeof(signed int));
		neuron[i].activation_function = act_func;
		neuron[i].output              = 0;

		if(neuron[i].sinaptic_weights == NULL) {
			printf("ERROR: Fail to allocate neuron's memory\n");
			return NULL;
		}

		for(w=0; w<neuron[i].num_of_weights; w++) {
			neuron[i].sinaptic_weights[w] = math_generate_random_number(l);
		}

		if(is_debug())
			neuron_print_single(neuron, i);
	}

	if(is_debug())
		printf("Neuron(s) initialized successfully\n");

	return neuron;
}


/*
 * Calculates an hidden neuron (k position) output
 */
void neuron_calculate_output(signed int activation_potential, neuron_t *hidden_neurons, unsigned int position)
{
	float neuron_output = 0;

	switch(hidden_neurons[position].activation_function)
	{
		case ACT_FUNC_SGN:
			neuron_output = math_signal_function(activation_potential);
			break;
		case ACT_FUNC_LINEAR:
			neuron_output = math_linear_function(activation_potential);
			break;
		case ACT_FUNC_SIGMOID:
			neuron_output = math_sigmoid_function(activation_potential);
			break;
		case ACT_FUNC_TANH:
			neuron_output = math_tanh_function(activation_potential);
			break;
		default:
			neuron_output = math_signal_function(activation_potential);
			break;
	}

	if(is_debug())
		printf("Calculating neuron's output [ %d ] using activation potential [ %d ]\n", position, activation_potential);

	hidden_neurons[position].output = neuron_output;

	if(is_debug())
		printf("Neuron [ %d ] output [ %f ]\n", position, neuron_output);

	return;
}

/*
 * Artificial Neuron Destroy
 *
 * Free memory allocation
 */
void neuron_destroy(neuron_t *neuron, unsigned int k)
{
	unsigned int i=0;

	for(i=0; i<k; i++) {
		if(is_debug())
			printf("Free sinaptic weights from neuron %d\n", i);

		free(neuron[i].sinaptic_weights);
	}

	if(is_debug())
		printf("Free neuron\n");

	free(neuron);
	return;
}

/*
 * Print all K neurons
 */
void neuron_print_all(neuron_t *neuron, unsigned int k)
{
	unsigned int i=0;

	printf("\n");
	for(i=0; i<k; i++) {
		neuron_print_single(neuron, i);
	}
}

/*
 * Print one single neurons
 */
void neuron_print_single(neuron_t *neuron, unsigned int i)
{
	unsigned int w=0;
	char act_func_str[64];

	printf("\n");
	math_activation_function_to_string(neuron[i].activation_function, act_func_str);

	printf("*********************************************************************************\n");
	printf("Neuron %d\n", i);
	printf("*********************************************************************************\n");
	printf("ID                   %d\n", neuron[i].id);
	printf("Number of Inputs     %d\n", neuron[i].num_of_inputs);
	printf("Number of Weights    %d\n", neuron[i].num_of_weights);
	printf("Weights Range        %d\n", neuron[i].weights_range);
	printf("Activation Function  %s\n", act_func_str);
	printf("Last Output          %f\n", neuron[i].output);

	printf("Sinaptic Weights     [ ");
	for(w=0; w<neuron[i].num_of_weights; w++) {
		printf("%d ", neuron[i].sinaptic_weights[w]);
	}
	printf("]\n");
	printf("*********************************************************************************\n");
}

