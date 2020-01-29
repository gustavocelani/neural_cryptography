
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
 # Creation Date: 19/09/2018
 # Creation Time: 08:02:54
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

clear
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

printf "Installing Dependences:\n";
printf "=======================\n\n";

printf "Installing gcc\n";
printf "           gnuplot\n";
printf "           eog\n";
printf "           tree\n\n";
sudo apt-get install gcc gnuplot eog tree

printf "\n";
printf "Compiling GC Neural Cryptography:\n";
printf "=================================\n\n";

printf "gcc gc_neural_crypto/main/gcnc.c gc_neural_crypto/source/neural_cryptography.c gc_neural_crypto/source/tree_parity_machine.c gc_neural_crypto/source/neuron.c gc_neural_crypto/source/mathematics.c -lm -o gc_neural_crypto/main/gcnc.o\n\n";
gcc gc_neural_crypto/main/gcnc.c gc_neural_crypto/source/neural_cryptography.c gc_neural_crypto/source/tree_parity_machine.c gc_neural_crypto/source/neuron.c gc_neural_crypto/source/mathematics.c -lm -o gc_neural_crypto/main/gcnc.o

printf "gcc gc_neural_crypto/main/bin_to_hex.c -o gc_neural_crypto/main/bin_to_hex.o\n\n";
gcc gc_neural_crypto/main/bin_to_hex.c -o gc_neural_crypto/main/bin_to_hex.o

printf "Compilation....................DONE\n";

printf "\n";
printf "Setting up Scripts Permissions:\n";
printf "===============================\n\n";

ls -lah *.sh
chmod +x *.sh
printf "Initial Scripts................DONE\n\n";

ls -lah scripts/*.sh
chmod +x scripts/*.sh
printf "General Scripts................DONE\n\n";

ls -lah scripts/graph/*.sh
chmod +x scripts/graph/*.sh
printf "Graph Scripts..................DONE\n\n";

tree

printf "###############################################################################\n";
printf "                Initial Setup and Compiling Done Successfully !                \n";
printf "###############################################################################\n\n";

printf "Now you can run GC Neural Cryptography following this steps:\n\n";

printf "Enter on scripts folder:\n"
printf "$ cd scripts/\n\n"

printf "Generates a single key using yours Tree Parity Machine's parameters\n";
printf "$ ./single_generation.sh\n\n";

printf "Generates multiples key using yours Tree Parity Machine's parameters\n";
printf "$ ./multiple_generation.sh\n\n";

printf "Generates multiples key using yours parameters comparing all learning rules\n";
printf "$ ./learning_rule_comparison.sh\n\n";

printf "Generates multiples key with arbitrary lenghts using optimal parameters\n";
printf "$ ./key_generation.sh\n\n";

printf "###############################################################################\n\n";

