
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
 # Creation Date: 09/10/2018
 # Creation Time: 22:09:45
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
NUMBER_OF_KEYS_MAX=1000000
PARAMETERS_MAX=1000000
PARAMETERS_MIN=1

# Plot Defines
PLOT_SGN_RAW='graph/plot_sgn.sh raw'
PLOT_SGN_GRAPHIC='graph/plot_sgn.sh graphic'
PLOT_LINEAR_RAW='graph/plot_linear.sh raw'
PLOT_LINEAR_GRAPHIC='graph/plot_linear.sh graphic'
PLOT_SIGMOID_RAW='graph/plot_sigmoid.sh raw'
PLOT_SIGMOID_GRAPHIC='graph/plot_sigmoid.sh graphic'
PLOT_TANH_RAW='graph/plot_tanh.sh raw'
PLOT_TANH_GRAPHIC='graph/plot_tanh.sh graphic'

# Plot Results
PLOT_VARIATION='graph/plot_variation.sh'

# Paths
GCNC_PATH='gc_neural_crypto/main/gcnc.o'
BIN_TO_HEX_PATH='gc_neural_crypto/main/bin_to_hex.o'

KEYS_BIN_PATH='../outputs/keys_bin.txt'
KEYS_HEX_PATH='../outputs/keys_hex.txt'
EPOCHS_PATH='../outputs/epochs.txt'
TIME_PATH='../outputs/time.txt'

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
		printf "Activation Function    Preview Graphic   Preview Raw\n";
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
			'a') # Signal Function Preview Graphic
				./${PLOT_SGN_GRAPHIC}
				;;
			'b') # Linear Function Preview Graphic
				./${PLOT_LINEAR_GRAPHIC}
				;;
			'c') # Sigmoid Function Preview Graphic
				./${PLOT_SIGMOID_GRAPHIC}
				;;
			'd') # Hyperbolic Tangent Function Preview Graphic
				./${PLOT_TANH_GRAPHIC}
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

	# Getting Numer of Generation
	while true; do
		printf "\n";
		printf "Number of Keys\n";
		read -p "-> " NUMBER_OF_KEYS

		if [[ ${NUMBER_OF_KEYS} -ge 1 && ${NUMBER_OF_KEYS} -le ${NUMBER_OF_KEYS_MAX} ]]
		then
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

	printf "Debug...................... Off\n\n"
	printf "Number of Keys............. ${NUMBER_OF_KEYS}\n"
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
	rm -rf ../outputs
	mkdir -p ../outputs
	../${GCNC_PATH} ${N} ${K} ${L} ${ACT_FUNC} ${LEARNING_RULE} 0 ${NUMBER_OF_KEYS}
}


convert_bin_keys_to_hex()
{
	touch ${KEYS_HEX_PATH}

	LINE_NUMBER=$(cat ${KEYS_BIN_PATH} | wc -l)
	for i in `seq 1 ${LINE_NUMBER}`
	do
		KEY_AUX=$(head -$i ${KEYS_BIN_PATH} | tail -1)
		../${BIN_TO_HEX_PATH} ${KEY_AUX}
	done
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

	print_parameters

	printf "Converting binary keys to hexadecimal...\r";
	convert_bin_keys_to_hex

	printf "\nCalculating metrics...\r";
	REPEATED_KEYS=$(cat ${KEYS_BIN_PATH}|sort|uniq -c|awk -F ' ' '{print $1}'|sort|head -n1)
	if [ ${REPEATED_KEYS} != 1 ]
	then
		printf "Number of Repeated Keys.... %d\n\n" ${REPEATED_KEYS}
	else
		printf "Number of Repeated Keys.... 0\n\n"
	fi

	################################## EPOCHS RESULTS ###################################

	printf "Calculating metrics...\r";
	EPOCHS_MAX=$(cat ${EPOCHS_PATH} | sort -n | tail -1)
	printf "Training Epochs Maximum.... %d\n" ${EPOCHS_MAX}

	printf "Calculating metrics...\r";
	EPOCHS_MIN=$(cat ${EPOCHS_PATH} | sort -n | head -1)
	printf "Training Epochs Minimum.... %d\n" ${EPOCHS_MIN}

	printf "Calculating metrics...\r";
	EPOCHS_AVERAGE=0
	LINE_NUMBER=$(cat ${EPOCHS_PATH} | wc -l)

	for i in `seq 1 ${LINE_NUMBER}`
	do
		EPOCH_AUX=$(head -$i ${EPOCHS_PATH} | tail -1)
		EPOCHS_AVERAGE=`expr ${EPOCHS_AVERAGE} + ${EPOCH_AUX}`
	done

	EPOCHS_AVERAGE=$(expr ${EPOCHS_AVERAGE} / ${LINE_NUMBER})
	EPOCHS_AVERAGE=$(expr ${EPOCHS_AVERAGE} + 1)
	printf "Training Epochs Average.... %d\n" ${EPOCHS_AVERAGE}

	############################### TRADED DATA RESULTS #################################

	printf "\nCalculating metrics...\r";
	INPUT_BIAS=$(expr ${INPUTS_BIAS} + 2)
	TRADED_AVERAGE=$(expr ${EPOCHS_AVERAGE} \* ${INPUT_BIAS})
	TRADED_AVERAGE=$(expr ${TRADED_AVERAGE} / 8)
	printf "Traded Messages Average.... %-10d Bytes\n" ${TRADED_AVERAGE}

	if [[ ${TRADED_AVERAGE} -ge 1024 ]]
	then
		printf "Calculating metrics...\r";
		TRADED_AVERAGE_KB=$(expr ${TRADED_AVERAGE} / 1024)
		printf "Traded Messages Average.... %-10d KBytes (rounded value)\n" ${TRADED_AVERAGE_KB}
	fi

	################################### TIME RESULTS ####################################

	printf "\nCalculating metrics...\r";
	TIME_MAX=$(cat ${TIME_PATH} | sort -n | tail -1)
	printf "Total Time Maximum......... %-10d microseconds\n" ${TIME_MAX}

	printf "Calculating metrics...\r";
	TIME_MIN=$(cat ${TIME_PATH} | sort -n | head -1)
	printf "Total Time Minimum......... %-10d microseconds\n" ${TIME_MIN}

	printf "Calculating metrics...\r";
	TIME_AVERAGE=0
	LINE_NUMBER=$(cat ${TIME_PATH} | wc -l)

	for i in `seq 1 ${LINE_NUMBER}`
	do
		TIME_AUX=$(head -$i ${TIME_PATH} | tail -1)
		TIME_AVERAGE=`expr ${TIME_AVERAGE} + ${TIME_AUX}`
	done

	TIME_AVERAGE=$(expr ${TIME_AVERAGE} / ${LINE_NUMBER})
	TIME_AVERAGE=$(expr ${TIME_AVERAGE} + 1)
	printf "Total Time Average......... %-10d microseconds\n" ${TIME_AVERAGE}

	if [[ ${TIME_AVERAGE} -ge 1000 ]]
	then
		printf "Calculating metrics...\r";
		TIME_AVERAGE_MILI=$(expr ${TIME_AVERAGE} / 1000)
		printf "Total Time Average......... %-10d miliseconds (rounded value)\n" ${TIME_AVERAGE_MILI}
	fi

	if [[ ${TIME_AVERAGE} -ge 1000000 ]]
	then
		printf "Calculating metrics...\r";
		TIME_AVERAGE_SEC=$(expr ${TIME_AVERAGE_MILI} / 1000)
		printf "Total Time Average......... %-10d seconds (rounded value)\n" ${TIME_AVERAGE_SEC}
	fi

	printf "\n###############################################################################\n\n";

	################################# GRAPHIC RESULTS ###################################

	while true; do
		read -p "Plot Results? [y/n] " CONFIRM
		if [[ ${CONFIRM} == 'n' ]]
		then
			break
		fi
		if [[ ${CONFIRM} == 'y' ]]
		then
			printf "Plotting Results\n"
			${PLOT_VARIATION} ${EPOCHS_AVERAGE} ${TIME_AVERAGE}
			break
		fi
	done

	################################## GENERATED KEYS ###################################

	while true; do
		printf "\nPrint outputs:\n";
		printf "[1] Binary\n";
		printf "[2] Hexadecimal\n";
		printf "[3] None\n";
		read -p "-> " PRINT

		if [[ ${PRINT} -ge 1 && ${PRINT} -le 3 ]]
		then
			break
		fi

	done

	if [[ ${PRINT} -eq 1 ]]
	then
		printf "\n";
		printf " ============================================================================= \n";
		printf "|                       Generated Keys                      | Training Epochs |\n";
		printf " ============================================================================= \n";

		LINE_NUMBER=$(cat ${KEYS_BIN_PATH} | wc -l)
		for i in `seq 1 ${LINE_NUMBER}`
		do
			KEY_AUX=$(head -$i ${KEYS_BIN_PATH} | tail -1)
			EPOCH_AUX=$(head -$i ${EPOCHS_PATH} | tail -1)
			printf "| %-57s | %-15s |\n" ${KEY_AUX:0:57} ${EPOCH_AUX:0:15}
		done

		printf " ============================================================================= \n";
		printf " * Raw Keys in ../outputs/keys_bin.txt\n"

	elif [[ ${PRINT} -eq 2 ]]
	then
		printf "\n";
		printf " ============================================================================= \n";
		printf "|                       Generated Keys                      | Training Epochs |\n";
		printf " ============================================================================= \n";

		LINE_NUMBER=$(cat ${KEYS_HEX_PATH} | wc -l)
		for i in `seq 1 ${LINE_NUMBER}`
		do
			KEY_AUX=$(head -$i ${KEYS_HEX_PATH} | tail -1)
			EPOCH_AUX=$(head -$i ${EPOCHS_PATH} | tail -1)
			printf "| %-57s | %-15s |\n" ${KEY_AUX:0:57} ${EPOCH_AUX:0:15}
		done

		printf " ============================================================================= \n";
		printf " * Raw Keys in ../outputs/keys_hex.txt\n"

	fi

	printf "\n###############################################################################\n";
}


run_again()
{
	printf "\n";

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

	# Printing result generated for gcnc
	print_result

	# Ask to run another time
	run_again

done

