
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
 * Creation Time: 14:19:58
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

/* GC Neural Cryptogrphy Custom Includes */
#include "../includes/gcnc_prototypes.h"

/*
 * Update Pseudo Random Seed
 */
void math_start_pseudo_random_generator(double seed)
{
	if(seed == 0) {
		srand( time(NULL) );
	} else {
		srand(seed);
	}

	return;
}

/*
 * Returns an random number in [ -range, +range ]
 */
signed int math_generate_random_number(unsigned int range)
{
    signed int gen         = 0;
    signed int low_number  = 0;
	signed int high_number = 0;

	signed int min = -range;
	signed int max = +range;

    if (min < max) {
		low_number  = min;
		high_number = max + 1;
    } else {
		low_number  = max + 1;
		high_number = min;
    }

    gen = (rand() % (high_number - low_number)) + low_number;
    return gen;
}

/*
 * Returns input array in [-1,+1] with predefined size
 *
 * BIAS Input will be always -1
 */
signed int *math_generate_input_array(unsigned int size, unsigned int n)
{
	float input;
	unsigned int i = 0;
	signed int *input_array;

   	input_array = malloc(size * sizeof(signed int));

	if(input_array == NULL) {
		printf("ERROR: Fail to allocate input array's memory\n");
		return NULL;
	}

	for(i=0; i<size; i++)
	{
		if((i == 0) || (i % (n+1) == 0)) {
			input_array[i] = -1;
			continue;
		}

		input = math_generate_random_number(100);
		if(input <= 0) {
			input = -1;
		} else {
			input = +1;
		}

		input_array[i] = input;
	}

	//printf("Input array generated with size %d [signed int]\n", size);
	return input_array;
}

/*
 * Signal Function
 */
float math_signal_function(float input)
{
	float output = 0;

	if(input <= 0) {
		output = -1;
	} else {
		output = +1;
	}

	//printf("Math Signal function input [ %f ] output [ %f ]\n", input, output);
	return output;
}

/*
 * Linear Function
 * f(x) = x
 */
float math_linear_function(float input)
{
	//printf("Math Linear function input [ %f ] output [ %f ]\n", input, input);
	return input;
}

/*
 * Sigmoid Function
 */
float math_sigmoid_function(float input)
{
	float output = 0;
    output = 1 / (1 + exp((double) -input));

	//printf("Math Sigmoid function input [ %f ] output [ %f ]\n", input, output);
	return output;
}

/*
 * Hyperbolic Tangent Function
 */
float math_tanh_function(float input)
{
	float output = 0;
    output = tanh(input);

	//printf("Math Sigmoid function input [ %f ] output [ %f ]\n", input, output);
	return output;
}

/*
 * Activation Function to String
 */
void math_activation_function_to_string(activation_function_t act_func, char *act_func_str)
{
	switch(act_func)
	{
		case ACT_FUNC_SGN:
			sprintf(act_func_str, "Signal");
			break;
		case ACT_FUNC_LINEAR:
			sprintf(act_func_str, "Linear");
			break;
		case ACT_FUNC_SIGMOID:
			sprintf(act_func_str, "Sigmoid");
			break;
		case ACT_FUNC_TANH:
			sprintf(act_func_str, "Hyperbolic Tangent");
			break;
		default:
			sprintf(act_func_str, "Sinal");
			break;
	}
}

