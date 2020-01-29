
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
 # Creation Date: 18/10/2018
 # Creation Time: 12:33:18
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

# Outputs Epochs Files
OUTPUT_EPOCHS_HEBBIAN_TXT='../outputs/epochs_hebbian.txt'
OUTPUT_EPOCHS_HEBBIAN_DAT='../outputs/epochs_hebbian.dat'
OUTPUT_EPOCHS_ANTI_HEBBIAN_TXT='../outputs/epochs_anti_hebbian.txt'
OUTPUT_EPOCHS_ANTI_HEBBIAN_DAT='../outputs/epochs_anti_hebbian.dat'
OUTPUT_EPOCHS_RANDOM_WALK_TXT='../outputs/epochs_random_walk.txt'
OUTPUT_EPOCHS_RANDOM_WALK_DAT='../outputs/epochs_random_walk.dat'

# Outputs Time Files
OUTPUT_TIME_HEBBIAN_TXT='../outputs/time_hebbian.txt'
OUTPUT_TIME_HEBBIAN_DAT='../outputs/time_hebbian.dat'
OUTPUT_TIME_ANTI_HEBBIAN_TXT='../outputs/time_anti_hebbian.txt'
OUTPUT_TIME_ANTI_HEBBIAN_DAT='../outputs/time_anti_hebbian.dat'
OUTPUT_TIME_RANDOM_WALK_TXT='../outputs/time_random_walk.txt'
OUTPUT_TIME_RANDOM_WALK_DAT='../outputs/time_random_walk.dat'

# Plot Results
PLOT_COMPARASION='./graph/plot_comparison.sh'

# Main path
GCNC_PATH='gc_neural_crypto/main/gcnc.o'

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

	# Graphic Style
	while true; do
		printf "\n";
		printf "Graphic Style\n"
		printf "[1] Separated Graphics\n";
		printf "[2] General View Graphics\n";
		read -p "-> " GRAPHIC_STYLE_INPUT

		if [[ ${GRAPHIC_STYLE_INPUT} -ge 1 && ${GRAPHIC_STYLE_INPUT} -le 2 ]]
		then
			GRAPHIC_STYLE=`expr ${GRAPHIC_STYLE_INPUT} - 1`
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

	printf "Debug...................... Off\n"

	printf "Graphic Style.............. "
	case ${GRAPHIC_STYLE} in
		0) # Separated Graphics
			printf "Separated Graphics\n";
			;;
		1) # General View Graphics
			printf "General View Graphics\n";
			;;
	esac

	printf "\nNumber of Keys............. ${NUMBER_OF_KEYS}\n"
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

	if [ ${ACT_FUNC} = 2 ] || [ ${ACT_FUNC} = 3 ]
	then
		printf "\n";
		printf "###############################################################################\n";
		printf "#                               !!! DANGER !!!                                #\n";
		printf "###############################################################################\n";
		printf "#    THE ARTIFICIAL NEURAL NETWORKS MAY NOT CONVERT WITH THIS CONFIGURATION   #\n";
		printf "###############################################################################\n";
	fi

	printf "\n"
	while true; do
		read -p "Confirm and start learning rules comparasion? [y/n] " CONFIRM
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

run_comparision()
{
	rm -rf ../outputs
	mkdir -p ../outputs

	# Hebbian Rule
	printf "Running with Hebbian Rule\n\n"
	../${GCNC_PATH} ${N} ${K} ${L} ${ACT_FUNC} 0 0 ${NUMBER_OF_KEYS}
	mv ../outputs/time.txt ${OUTPUT_TIME_HEBBIAN_TXT}
	mv ../outputs/epochs.txt ${OUTPUT_EPOCHS_HEBBIAN_TXT}

	printf "\n###############################################################################\n\n";

	# Anti Hebbian Rule
	printf "Running with Anti Hebbian Rule\n\n"
	../${GCNC_PATH} ${N} ${K} ${L} ${ACT_FUNC} 1 0 ${NUMBER_OF_KEYS}
	mv ../outputs/time.txt ${OUTPUT_TIME_ANTI_HEBBIAN_TXT}
	mv ../outputs/epochs.txt ${OUTPUT_EPOCHS_ANTI_HEBBIAN_TXT}

	printf "\n###############################################################################\n\n";

	# Random Walk Rule
	printf "Running with Random Walk Rule\n\n"
	../${GCNC_PATH} ${N} ${K} ${L} ${ACT_FUNC} 2 0 ${NUMBER_OF_KEYS}
	mv ../outputs/time.txt ${OUTPUT_TIME_RANDOM_WALK_TXT}
	mv ../outputs/epochs.txt ${OUTPUT_EPOCHS_RANDOM_WALK_TXT}

	rm ../outputs/keys_bin.txt
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

	################################## HEBBIAN ###################################

	printf "\nCalculating hebbian metrics...\r";
	EPOCHS_HEBBIAN_AVERAGE=0
	LINE_NUMBER=$(cat ${OUTPUT_EPOCHS_HEBBIAN_TXT} | wc -l)

	for i in `seq 1 ${LINE_NUMBER}`
	do
		EPOCH_AUX=$(head -$i ${OUTPUT_EPOCHS_HEBBIAN_TXT} | tail -1)
		EPOCHS_HEBBIAN_AVERAGE=`expr ${EPOCHS_HEBBIAN_AVERAGE} + ${EPOCH_AUX}`
	done

	EPOCHS_HEBBIAN_AVERAGE=$(expr ${EPOCHS_HEBBIAN_AVERAGE} / ${LINE_NUMBER})
	EPOCHS_HEBBIAN_AVERAGE=$(expr ${EPOCHS_HEBBIAN_AVERAGE} + 1)
	printf "Hebbian epochs average calculated\n";

	printf "Calculating hebbian metrics...\r";
	cat -n ${OUTPUT_EPOCHS_HEBBIAN_TXT} > ${OUTPUT_EPOCHS_HEBBIAN_DAT}
	printf "Hebbian epochs .dat file generated\n";

	printf "Calculating hebbian metrics...\r";
	TIME_HEBBIAN_AVERAGE=0
	LINE_NUMBER=$(cat ${OUTPUT_TIME_HEBBIAN_TXT} | wc -l)

	for i in `seq 1 ${LINE_NUMBER}`
	do
		TIME_AUX=$(head -$i ${OUTPUT_TIME_HEBBIAN_TXT} | tail -1)
		TIME_HEBBIAN_AVERAGE=`expr ${TIME_HEBBIAN_AVERAGE} + ${TIME_AUX}`
	done

	TIME_HEBBIAN_AVERAGE=$(expr ${TIME_HEBBIAN_AVERAGE} / ${LINE_NUMBER})
	TIME_HEBBIAN_AVERAGE=$(expr ${TIME_HEBBIAN_AVERAGE} + 1)
	printf "Hebbian time average calculated\n";

	printf "Calculating hebbian metrics...\r";
	cat -n ${OUTPUT_TIME_HEBBIAN_TXT} > ${OUTPUT_TIME_HEBBIAN_DAT}
	printf "Hebbian time .dat file generated\n";

	############################### ANTI HEBBIAN #################################

	printf "\nCalculating anti hebbian metrics...\r";
	EPOCHS_ANTI_HEBBIAN_AVERAGE=0
	LINE_NUMBER=$(cat ${OUTPUT_EPOCHS_ANTI_HEBBIAN_TXT} | wc -l)

	for i in `seq 1 ${LINE_NUMBER}`
	do
		EPOCH_AUX=$(head -$i ${OUTPUT_EPOCHS_ANTI_HEBBIAN_TXT} | tail -1)
		EPOCHS_ANTI_HEBBIAN_AVERAGE=`expr ${EPOCHS_ANTI_HEBBIAN_AVERAGE} + ${EPOCH_AUX}`
	done

	EPOCHS_ANTI_HEBBIAN_AVERAGE=$(expr ${EPOCHS_ANTI_HEBBIAN_AVERAGE} / ${LINE_NUMBER})
	EPOCHS_ANTI_HEBBIAN_AVERAGE=$(expr ${EPOCHS_ANTI_HEBBIAN_AVERAGE} + 1)
	printf "Anti Hebbian epochs average calculated\n";

	printf "Calculating anti hebbian metrics...\r";
	cat -n ${OUTPUT_EPOCHS_ANTI_HEBBIAN_TXT} > ${OUTPUT_EPOCHS_ANTI_HEBBIAN_DAT}
	printf "Anti Hebbian epochs .dat file generated\n";

	printf "Calculating anti hebbian metrics...\r";
	TIME_ANTI_HEBBIAN_AVERAGE=0
	LINE_NUMBER=$(cat ${OUTPUT_TIME_ANTI_HEBBIAN_TXT} | wc -l)

	for i in `seq 1 ${LINE_NUMBER}`
	do
		TIME_AUX=$(head -$i ${OUTPUT_TIME_ANTI_HEBBIAN_TXT} | tail -1)
		TIME_ANTI_HEBBIAN_AVERAGE=`expr ${TIME_ANTI_HEBBIAN_AVERAGE} + ${TIME_AUX}`
	done

	TIME_ANTI_HEBBIAN_AVERAGE=$(expr ${TIME_ANTI_HEBBIAN_AVERAGE} / ${LINE_NUMBER})
	TIME_ANTI_HEBBIAN_AVERAGE=$(expr ${TIME_ANTI_HEBBIAN_AVERAGE} + 1)
	printf "Anti Hebbian average time calculated\n";

	printf "Calculating anti hebbian metrics...\r";
	cat -n ${OUTPUT_TIME_ANTI_HEBBIAN_TXT} > ${OUTPUT_TIME_ANTI_HEBBIAN_DAT}
	printf "Anti Hebbian time .dat file generated\n";

	############################### RANDOM WALK ##################################

	printf "\nCalculating random walk metrics...\r";
	EPOCHS_RANDOM_WALK_AVERAGE=0
	LINE_NUMBER=$(cat ${OUTPUT_EPOCHS_RANDOM_WALK_TXT} | wc -l)

	for i in `seq 1 ${LINE_NUMBER}`
	do
		EPOCH_AUX=$(head -$i ${OUTPUT_EPOCHS_RANDOM_WALK_TXT} | tail -1)
		EPOCHS_RANDOM_WALK_AVERAGE=`expr ${EPOCHS_RANDOM_WALK_AVERAGE} + ${EPOCH_AUX}`
	done

	EPOCHS_RANDOM_WALK_AVERAGE=$(expr ${EPOCHS_RANDOM_WALK_AVERAGE} / ${LINE_NUMBER})
	EPOCHS_RANDOM_WALK_AVERAGE=$(expr ${EPOCHS_RANDOM_WALK_AVERAGE} + 1)
	printf "Random Walk epochs average calculated\n";

	printf "Calculating random walk metrics...\r";
	cat -n ${OUTPUT_EPOCHS_RANDOM_WALK_TXT} > ${OUTPUT_EPOCHS_RANDOM_WALK_DAT}
	printf "Random walk epochs .dat file generated\n";

	printf "Calculating anti hebbian metrics...\r";
	TIME_RANDOM_WALK_AVERAGE=0
	LINE_NUMBER=$(cat ${OUTPUT_TIME_RANDOM_WALK_TXT} | wc -l)

	for i in `seq 1 ${LINE_NUMBER}`
	do
		TIME_AUX=$(head -$i ${OUTPUT_TIME_RANDOM_WALK_TXT} | tail -1)
		TIME_RANDOM_WALK_AVERAGE=`expr ${TIME_RANDOM_WALK_AVERAGE} + ${TIME_AUX}`
	done

	TIME_RANDOM_WALK_AVERAGE=$(expr ${TIME_RANDOM_WALK_AVERAGE} / ${LINE_NUMBER})
	TIME_RANDOM_WALK_AVERAGE=$(expr ${TIME_RANDOM_WALK_AVERAGE} + 1)
	printf "Random walk average time calculated\n";

	printf "Calculating random walk metrics...\r";
	cat -n ${OUTPUT_TIME_RANDOM_WALK_TXT} > ${OUTPUT_TIME_RANDOM_WALK_DAT}
	printf "Randon walk time .dat file generated\n";

	printf "\n###############################################################################\n\n";

	########################### GENERATING GRAPHICS ##############################

	printf "Plotting results\n"
	${PLOT_COMPARASION} ${EPOCHS_HEBBIAN_AVERAGE} ${EPOCHS_ANTI_HEBBIAN_AVERAGE} ${EPOCHS_RANDOM_WALK_AVERAGE} ${TIME_HEBBIAN_AVERAGE} ${TIME_ANTI_HEBBIAN_AVERAGE} ${TIME_RANDOM_WALK_AVERAGE} ${GRAPHIC_STYLE}

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

	# Running comparision
	run_comparision

	# Printing result generated for gcnc
	print_result

	# Ask to run another time
	run_again

done

