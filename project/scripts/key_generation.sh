
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
PARAMETERS_MAX=1000000

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
	printf "|                              Parametrization                                |\n";
	printf " ============================================================================= \n";

	# Getting Key size
	while true; do
		printf "\n";
		printf "Key Size [bits]: ";
		read -p "" KEY_SIZE

		if [[ ${KEY_SIZE} -ge 1 && ${PARAMETERS_MAX} -le ${PARAMETERS_MAX} ]]
		then
			break
		fi
	done


	# Getting Numer of Generation
	while true; do
		printf "\n";
		printf "Number of Keys: ";
		read -p "" NUMBER_OF_KEYS

		if [[ ${NUMBER_OF_KEYS} -ge 1 && ${NUMBER_OF_KEYS} -le ${PARAMETERS_MAX} ]]
		then
			break
		fi
	done
}


print_parameters()
{
	printf "K Value.................... 1\n";
	printf "N Value.................... ${KEY_SIZE}\n";
	printf "L Value.................... 2\n";

	INPUTS_BIAS=`expr ${KEY_SIZE} + 1`
	printf "\n";
	printf "Number of Inputs........... ${KEY_SIZE}\n";
	printf "Input Array Size........... ${INPUTS_BIAS}\n";
	printf "Key   Array Size........... ${KEY_SIZE}\n";

	printf "\nActivation Function........ Signal Function\n"
	printf "Learning Rule.............. Anti-Hebbian Rule\n"

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
	printf "|                              Parametrization                                |\n";
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
	../${GCNC_PATH} ${KEY_SIZE} 1 2 0 1 0 ${NUMBER_OF_KEYS}
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

