
 #*******************************************************************************
 #          ____________            _   __________  ______  ___    __
 #         / ____/ ____/           / | / / ____/ / / / __ \/   |  / /
 #        / / __/ /      ______   /  |/ / __/ / / / / /_/ / /| | / /
 #       / /_/ / /___   /_____/  / /|  / /___/ /_/ / _, _/ ___ |/ /___
 #       \____/\____/           /_/ |_/_____/\____/_/ |_/_/  |_/_____/
 #    ____________  ______  __________  __________  ___    ____  __  ____  __
 #   / ____/ __ \ \/ / __ \/_  __/ __ \/ ____/ __ \/   |  / __ \/ / / /\ \/ /
 #  / /   / /_/ /\  / /_/ / / / / / / / / __/ /_/ / /| | / /_/ / /_/ /  \  /
 # / /___/ _, _/ / / ____/ / / / /_/ / /_/ / _, _/ ___ |/ ____/ __  /   / /
 # \____/_/ |_| /_/_/     /_/  \____/\____/_/ |_/_/  |_/_/   /_/ /_/   /_/
 #
 #*******************************************************************************
 #              Copyright (C) Gustavo Celani - All Rights Reserved
 #    Written by Gustavo Celani <gustavo_celani@hotmail.com>, September 2018
 #*******************************************************************************
 # Creation Date: 18/09/2018
 # Creation Time: 14:16:31
 #
 # Version:     1.0
 # Interpreter: sh
 #
 # Author:   Gustavo Pasqua de Oliveira Celani
 # Social:   GC - Gustavo Celani (@gustavo_celani)
 # Email:    gustavo_celani@hotmail.com
 # Linkedin: https://br.linkedin.com/in/gustavocelani
 #
 # Project Available on: https://github.com/gustavocelani/TCC_ANNCKG_Project.git
 # Article Available on: https://github.com/gustavocelani/TCC_ANNCKG_Article.git
 #*******************************************************************************

#!/bin/sh


# Script Vairables
PARAMETERS_MAX=1000000
PARAMETERS_MIN=1


# Plot Defines
PLOT_SGN_RAW='graph/plot_sgn.sh raw'
PLOT_SGN_GRAPHYC='graph/plot_sgn.sh graphyc'
PLOT_LINEAR_RAW='graph/plot_linear.sh raw'
PLOT_LINEAR_GRAPHYC='graph/plot_linear.sh graphyc'
PLOT_SIGMOID_RAW='graph/plot_sigmoid.sh raw'
PLOT_SIGMOID_GRAPHYC='graph/plot_sigmoid.sh graphyc'
PLOT_TANH_RAW='graph/plot_tanh.sh raw'
PLOT_TANH_GRAPHYC='graph/plot_tanh.sh graphyc'


# Paths
GCNC_PATH='gc_neural_crypto/main/gcnc.o'
KEYS_BIN_PATH='../outputs/keys_bin.txt'
EPOCHS_PATH='../outputs/epochs.txt'


check_current_path()
{
	CURRENT_PATH=`pwd | awk -F '/' '{print $NF}'`

	if [[ "${CURRENT_PATH}" != "scripts" ]]
	then
		printf "                                                                               \n";
		printf "###############################################################################\n";
		printf "          ____________            _   __________  ______  ___    __            \n";
		printf "         / ____/ ____/           / | / / ____/ / / / __ \\/   |  / /           \n";
		printf "        / / __/ /      ______   /  |/ / __/ / / / / /_/ / /| | / /             \n";
		printf "       / /_/ / /___   /_____/  / /|  / /___/ /_/ / _, _/ ___ |/ /___           \n";
		printf "       \\____/\\____/           /_/ |_/_____/\\____/_/ |_/_/  |_/_____/        \n";
		printf "    ____________  ______  __________  __________  ___    ____  __  ____  __    \n";
		printf "   / ____/ __ \\ \\/ / __ \\/_  __/ __ \\/ ____/ __ \\/   |  / __ \\/ / / /\\ \\/ /\n";
		printf "  / /   / /_/ /\\  / /_/ / / / / / / / / __/ /_/ / /| | / /_/ / /_/ /  \\  /   \n";
		printf " / /___/ _, _/ / / ____/ / / / /_/ / /_/ / _, _/ ___ |/ ____/ __  /   / /      \n";
		printf " \\____/_/ |_| /_/_/     /_/  \\____/\\____/_/ |_/_/  |_/_/   /_/ /_/   /_/    \n";
		printf "                                                                               \n";
		printf "###############################################################################\n\n";
		printf "Please, only run scripts of directory scripts/\n";
		printf "$ cd scripts/\n\n";
		printf "###############################################################################\n\n";
		exit
	fi
}


get_parameters()
{
	printf "                                                                               \n";
	printf "###############################################################################\n";
	printf "          ____________            _   __________  ______  ___    __            \n";
	printf "         / ____/ ____/           / | / / ____/ / / / __ \\/   |  / /           \n";
	printf "        / / __/ /      ______   /  |/ / __/ / / / / /_/ / /| | / /             \n";
	printf "       / /_/ / /___   /_____/  / /|  / /___/ /_/ / _, _/ ___ |/ /___           \n";
	printf "       \\____/\\____/           /_/ |_/_____/\\____/_/ |_/_/  |_/_____/        \n";
	printf "    ____________  ______  __________  __________  ___    ____  __  ____  __    \n";
	printf "   / ____/ __ \\ \\/ / __ \\/_  __/ __ \\/ ____/ __ \\/   |  / __ \\/ / / /\\ \\/ /\n";
	printf "  / /   / /_/ /\\  / /_/ / / / / / / / / __/ /_/ / /| | / /_/ / /_/ /  \\  /   \n";
	printf " / /___/ _, _/ / / ____/ / / / /_/ / /_/ / _, _/ ___ |/ ____/ __  /   / /      \n";
	printf " \\____/_/ |_| /_/_/     /_/  \\____/\\____/_/ |_/_/  |_/_/   /_/ /_/   /_/    \n";
	printf "                                                                               \n";
	printf "###############################################################################\n\n";

	printf " ============================================================================= \n";
	printf "|                     Tree Parity Machine Parametrization                     |\n";
	printf " ============================================================================= \n\n";

	# Getting K Parameter
	while true; do
		read -p "Parameter K: " K
		if [[ ${K} -ge ${PARAMETERS_MIN} && ${K} -le ${PARAMETERS_MAX} ]]
		then
			break
		fi
	done

	# Getting N Parameter
	while true; do
		read -p "Parameter N: " N
		if [[ ${N} -ge ${PARAMETERS_MIN} && ${N} -le ${PARAMETERS_MAX} ]]
		then
			break
		fi
	done

	# Getting L Parameter
	while true; do
		read -p "Parameter L: " L
		if [[ ${L} -ge ${PARAMETERS_MIN} && ${L} -le ${PARAMETERS_MAX} ]]
		then
			break
		fi
	done

	# Getting Activation Function
	while true; do
		printf "\n";
		printf "Activation Function    Preview Graphyc   Preview Raw\n";
		printf "[1] Signal                   [a]              [e]   \n";
		printf "[2] Linear                   [b]              [f]   \n";
		printf "[3] Sigmoid                  [c]              [g]   \n";
		printf "[4] Hyperbolic Tangent       [d]              [h]   \n";
		read -p "-> " ACT_FUNC_INPUT

		if [[ ${ACT_FUNC_INPUT} -ge 1 && ${ACT_FUNC_INPUT} -le 4 ]]
		then
			ACT_FUNC=`expr ${ACT_FUNC_INPUT} - 1`
			break
		fi

		case ${ACT_FUNC_INPUT} in
			'a') # Signal Function Preview Graphyc
				./${PLOT_SGN_GRAPHYC}
				;;
			'b') # Linear Function Preview Graphyc
				./${PLOT_LINEAR_GRAPHYC}
				;;
			'c') # Sigmoid Function Preview Graphyc
				./${PLOT_SIGMOID_GRAPHYC}
				;;
			'd') # Hyperbolic Tangent Function Preview Graphyc
				./${PLOT_TANH_GRAPHYC}
				;;
			'e') # Signal Function Preview Raw
				./${PLOT_SGN_RAW}
				;;
			'f') # Linear Function Preview Raw
				./${PLOT_LINEAR_RAW}
				;;
			'g') # Sigmoid Function Preview Raw
				./${PLOT_SIGMOID_RAW}
				;;
			'h') # Hyperbolic Tangent Function Preview Raw
				./${PLOT_TANH_RAW}
				;;
		esac
	done

	# Removing possible activation functions preview
	rm -f *.jpeg

	# Getting Learning Rule
	while true; do
		printf "\n";
		printf "Learning Rule\n";
		printf "[1] Hebbian\n";
		printf "[2] Anti-Hebbian\n";
		printf "[3] Random Walk\n";
		read -p "-> " LEARNING_RULE_INPUT

		if [[ ${LEARNING_RULE_INPUT} -ge 1 && ${LEARNING_RULE_INPUT} -le 3 ]]
		then
			LEARNING_RULE=`expr ${LEARNING_RULE_INPUT} - 1`
			break
		fi
	done

	# Getting Debug Mode
	while true; do
		printf "\n";
		printf "Debug Mode\n";
		printf "[1] Off\n";
		printf "[2] On\n";
		read -p "-> " DEBUG_INPUT

		if [[ ${DEBUG_INPUT} -ge 1 && ${DEBUG_INPUT} -le 2 ]]
		then
			DEBUG=`expr ${DEBUG_INPUT} - 1`
			break
		fi
	done
}


print_parameters()
{
	printf "K Value.................... ${K}\n";
	printf "N Value.................... ${N}\n";
	printf "L Value.................... ${L}\n";

	INPUTS=`expr ${K} \\* ${N}`
	INPUTS_BIAS=`expr ${INPUTS} + ${K}`
	printf "\n";
	printf "Number of Inputs........... ${INPUTS}\n";
	printf "Input Array Size........... ${INPUTS_BIAS}\n";
	printf "Key   Array Size........... ${INPUTS}\n";

	printf "\nActivation Function........ "
	case ${ACT_FUNC} in
		0) # Signal Function
			printf "Signal Function\n"
			;;
		1) # Linear Function
			printf "Linear Function\n"
			;;
		2) # Sigmoid Function
			printf "Sigmoid Function\n"
			;;
		3) # Hyperbolic Tangent Function
			printf "Hyperbolic Tangent Function\n"
			;;
	esac

	printf "Learning Rule.............. "
	case ${LEARNING_RULE} in
		0) # Hebbian Rule
			printf "Hebbian Rule\n"
			;;
		1) # Anti-Hebbian Rule
			printf "Anti-Hebbian Rule\n"
			;;
		2) # Random Walk Rule
			printf "Random Walk Rule\n"
			;;
	esac

	printf "Debug...................... "
	case ${DEBUG} in
		0) # Off
			printf "Off\n"
			;;
		1) # On
			printf "On\n"
			;;
	esac
}


confirm_parameters()
{
	printf "                                                                               \n";
	printf "###############################################################################\n";
	printf "          ____________            _   __________  ______  ___    __            \n";
	printf "         / ____/ ____/           / | / / ____/ / / / __ \\/   |  / /           \n";
	printf "        / / __/ /      ______   /  |/ / __/ / / / / /_/ / /| | / /             \n";
	printf "       / /_/ / /___   /_____/  / /|  / /___/ /_/ / _, _/ ___ |/ /___           \n";
	printf "       \\____/\\____/           /_/ |_/_____/\\____/_/ |_/_/  |_/_____/        \n";
	printf "    ____________  ______  __________  __________  ___    ____  __  ____  __    \n";
	printf "   / ____/ __ \\ \\/ / __ \\/_  __/ __ \\/ ____/ __ \\/   |  / __ \\/ / / /\\ \\/ /\n";
	printf "  / /   / /_/ /\\  / /_/ / / / / / / / / __/ /_/ / /| | / /_/ / /_/ /  \\  /   \n";
	printf " / /___/ _, _/ / / ____/ / / / /_/ / /_/ / _, _/ ___ |/ ____/ __  /   / /      \n";
	printf " \\____/_/ |_| /_/_/     /_/  \\____/\\____/_/ |_/_/  |_/_/   /_/ /_/   /_/    \n";
	printf "                                                                               \n";
	printf "###############################################################################\n\n";

	printf " ============================================================================= \n";
	printf "|                     Tree Parity Machine Parametrization                     |\n";
	printf " ============================================================================= \n\n";

	print_parameters

	printf "\n"
	while true; do
		read -p "Confirm and start key generation? [y/n] " CONFIRM
		if [[ ${CONFIRM} == 'n' ]]
		then
			exit 0;
		fi
		if [[ ${CONFIRM} == 'y' ]]
		then
			break
		fi
	done

	printf "\n###############################################################################\n\n";
}


run_gc_neural_cryptography()
{
	mkdir -p ../outputs
	../${GCNC_PATH} ${N} ${K} ${L} ${ACT_FUNC} ${LEARNING_RULE} ${DEBUG} 1
}


print_result()
{
	printf "                                                                               \n";
	printf "###############################################################################\n";
	printf "          ____________            _   __________  ______  ___    __            \n";
	printf "         / ____/ ____/           / | / / ____/ / / / __ \\/   |  / /           \n";
	printf "        / / __/ /      ______   /  |/ / __/ / / / / /_/ / /| | / /             \n";
	printf "       / /_/ / /___   /_____/  / /|  / /___/ /_/ / _, _/ ___ |/ /___           \n";
	printf "       \\____/\\____/           /_/ |_/_____/\\____/_/ |_/_/  |_/_____/        \n";
	printf "    ____________  ______  __________  __________  ___    ____  __  ____  __    \n";
	printf "   / ____/ __ \\ \\/ / __ \\/_  __/ __ \\/ ____/ __ \\/   |  / __ \\/ / / /\\ \\/ /\n";
	printf "  / /   / /_/ /\\  / /_/ / / / / / / / / __/ /_/ / /| | / /_/ / /_/ /  \\  /   \n";
	printf " / /___/ _, _/ / / ____/ / / / /_/ / /_/ / _, _/ ___ |/ ____/ __  /   / /      \n";
	printf " \\____/_/ |_| /_/_/     /_/  \\____/\\____/_/ |_/_/  |_/_/   /_/ /_/   /_/    \n";
	printf "                                                                               \n";
	printf "###############################################################################\n\n";

	printf " ============================================================================= \n";
	printf "|                          Key Generated Successfully                         |\n";
	printf " ============================================================================= \n\n";

	printf " ============================================================================= \n";
	printf "|                       Generated Keys                      | Training Epochs |\n";
	printf " ============================================================================= \n";

	LINE_NUMBER=$(cat ${KEYS_BIN_PATH} | wc -l)
	for i in `seq 1 ${LINE_NUMBER}`
	do
		KEY_AUX=$(head -$i ${KEYS_BIN_PATH} | tail -1)
		EPOCH_AUX=$(head -$i ${EPOCHS_PATH} | tail -1)
		printf "| %-57s | %-15s |\n" ${KEY_AUX} ${EPOCH_AUX}
	done

	printf " ============================================================================= \n";

	printf "\n###############################################################################\n\n";
}


run_again()
{
	while true; do
		read -p "Run again? [y/n] " CONFIRM
		if [[ ${CONFIRM} == 'n' ]]
		then
			exit 0;
		fi
		if [[ ${CONFIRM} == 'y' ]]
		then
			break
		fi
	done
}


# Main Loop
while true; do

	# Start
	clear
	check_current_path

	# Parametrization
	get_parameters

	# Confirm Parameters
	clear
	confirm_parameters

	# Running gc_neural_cryptography
	run_gc_neural_cryptography

	# Clear to print results and metrics
	if [[ ${DEBUG} -eq 1 ]]
	then
		clear
	fi

	# Printing result generated for gcnc
	print_result

	# Ask to run another time
	run_again

done

