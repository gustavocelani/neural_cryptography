
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

#ifndef GCNC_DEFINITIONS_H
#define GCNC_DEFINITIONS_H

/*
 * Activation Functions
 */
typedef enum
{
	ACT_FUNC_SGN,        /* y = sgn(x)                      */
	ACT_FUNC_LINEAR,     /* y = x                           */
	ACT_FUNC_SIGMOID,    /* y = 1 / (1 - e^-x)              */
	ACT_FUNC_TANH        /* y = (e^x - e^-x) / (e^x + e^-x) */
} activation_function_t;


/*
 * Artificial Neuron
 */
typedef struct
{
	unsigned short int     id;                    /* Neuron identifier (index) */
	unsigned int           num_of_inputs;         /* N (Tree Parity Machine)   */
	unsigned int           num_of_weights;        /* N + 1 (Bias)              */
	unsigned int           weights_range;         /* L (Tree Parity Machine)   */
	signed int             *sinaptic_weights;     /* Sinaptic Weights          */
	float                  output;                /* Neuron's output           */
	activation_function_t  activation_function;   /* Activation Function       */
} neuron_t;


/*
 * Learning Rules
 */
typedef enum
{
	LEARNING_RULE_HEBBIAN,       /* Hebbian Learning Rule      */
	LEARNING_RULE_ANTI_HEBBIAN,  /* Anti Hebbian Learning Rule */
	LEARNING_RULE_RANDOM_WALK    /* Random Walk Learning Rule  */
} learning_rule_t;


/*
 * Tree Parity Machine Identification
 */
#define TREE_PARITY_MACHINE_A 0
#define TREE_PARITY_MACHINE_B 1


/*
 * Epsilon used to compare double values
 */
#define EPSILON 1

/*
 * Tree Parity Machine
 */
typedef struct
{
	unsigned int id;                 /* Identification           */
	unsigned int k;                  /* Number of Hidden Neurons */
	unsigned int n;                  /* Inputs for Neuron        */
	unsigned int l;                  /* Weights Range            */
	unsigned int num_of_inputs;      /* (K*N)+K Includind BIAS   */
	unsigned int epochs;             /* Training Epochs          */
	signed   int output;             /* ANN Output               */
	neuron_t *hidden_neurons;        /* Hidden Layer Neurons     */
	learning_rule_t learning_rule;   /* Learning Rule            */
} tree_parity_machine_t;


#endif

