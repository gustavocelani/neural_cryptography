
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
 # Creation Time: 14:20:46
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

# Outputs Epochs Files
OUTPUT_EPOCHS_HEBBIAN_DAT='../outputs/epochs_hebbian.dat'
OUTPUT_EPOCHS_ANTI_HEBBIAN_DAT='../outputs/epochs_anti_hebbian.dat'
OUTPUT_EPOCHS_RANDOM_WALK_DAT='../outputs/epochs_random_walk.dat'

# Outputs Time Files
OUTPUT_TIME_HEBBIAN_DAT='../outputs/time_hebbian.dat'
OUTPUT_TIME_ANTI_HEBBIAN_DAT='../outputs/time_anti_hebbian.dat'
OUTPUT_TIME_RANDOM_WALK_DAT='../outputs/time_random_walk.dat'

# General Result Files
GENERAL_RESULT='../outputs/comparison.jpeg'

# Epochs Result Files
EPOCHS_RESULT_CONTINUOUS='../outputs/epochs_comparison_continuous.jpeg'
EPOCHS_RESULT_DISCRETE='../outputs/epochs_comparison_discrete.jpeg'

# Time Result Files
TIME_RESULT_CONTINUOUS='../outputs/time_comparison_continuous.jpeg'
TIME_RESULT_DISCRETE='../outputs/time_comparison_discrete.jpeg'

plot_separated()
{
	gnuplot -e "set terminal jpeg large size 1600,750;
				set title \"Epochs Comparison (Continuous)\";
				set xlabel \"Key\";
				set ylabel \"Epochs to Synchronize\";
				set grid;
				set border 1;
				plot '${OUTPUT_EPOCHS_HEBBIAN_DAT}' with line linetype rgbcolor \"red\" linewidth 1 title \"Hebbian\",
				'${OUTPUT_EPOCHS_ANTI_HEBBIAN_DAT}' with line linetype rgbcolor \"blue\" linewidth 1 title \"Anti-Hebbian\",
				'${OUTPUT_EPOCHS_RANDOM_WALK_DAT}' with line linetype rgbcolor \"green\" linewidth 1 title \"Random Walk\";
				" > ${EPOCHS_RESULT_CONTINUOUS}

	eog ${EPOCHS_RESULT_CONTINUOUS}

	##########################################################################################################

	gnuplot -e "set terminal jpeg large size 1600,750;
				set title \"Epochs Comparison (Discrete)\";
				set xlabel \"Key\";
				set ylabel \"Epochs to Synchronize\";
				set grid;
				set border 1;
				plot '${OUTPUT_EPOCHS_HEBBIAN_DAT}' linetype rgbcolor \"red\" linewidth 1 title \"Hebbian\",
				'${OUTPUT_EPOCHS_ANTI_HEBBIAN_DAT}' linetype rgbcolor \"blue\" linewidth 1 title \"Anti-Hebbian\",
				'${OUTPUT_EPOCHS_RANDOM_WALK_DAT}' linetype rgbcolor \"green\" linewidth 1 title \"Random Walk\",
				$1 with line linetype rgbcolor \"red\" linewidth 2 title \"Hebbian Average $1\",
				$2 with line linetype rgbcolor \"blue\" linewidth 2 title \"Anti-Hebbian Average $2\",
				$3 with line linetype rgbcolor \"green\" linewidth 2 title \"Random-Walk Average $3\";
				" > ${EPOCHS_RESULT_DISCRETE}

	eog ${EPOCHS_RESULT_DISCRETE}

	##########################################################################################################

	gnuplot -e "set terminal jpeg large size 1600,750;
				set title \"Time Comparison (Continuous)\";
				set xlabel \"Key\";
				set ylabel \"Time for Generate each Key [microseconds]\";
				set grid;
				set border 1;
				plot '${OUTPUT_TIME_HEBBIAN_DAT}' with line linetype rgbcolor \"red\" linewidth 1 title \"Hebbian\",
				'${OUTPUT_TIME_ANTI_HEBBIAN_DAT}' with line linetype rgbcolor \"blue\" linewidth 1 title \"Anti-Hebbian\",
				'${OUTPUT_TIME_RANDOM_WALK_DAT}' with line linetype rgbcolor \"green\" linewidth 1 title \"Random Walk\";
				" > ${TIME_RESULT_CONTINUOUS}

	eog ${TIME_RESULT_CONTINUOUS}

	##########################################################################################################

	gnuplot -e "set terminal jpeg large size 1600,750;
				set title \"Epochs Comparison (Discrete)\";
				set xlabel \"Key\";
				set ylabel \"Epochs to Synchronize\";
				set grid;
				set border 1;
				plot '${OUTPUT_TIME_HEBBIAN_DAT}' linetype rgbcolor \"red\" linewidth 1 title \"Hebbian\",
				'${OUTPUT_TIME_ANTI_HEBBIAN_DAT}' linetype rgbcolor \"blue\" linewidth 1 title \"Anti-Hebbian\",
				'${OUTPUT_TIME_RANDOM_WALK_DAT}' linetype rgbcolor \"green\" linewidth 1 title \"Random Walk\",
				$4 with line linetype rgbcolor \"red\" linewidth 2 title \"Hebbian Average $4\",
				$5 with line linetype rgbcolor \"blue\" linewidth 2 title \"Anti-Hebbian Average $5\",
				$6 with line linetype rgbcolor \"green\" linewidth 2 title \"Random-Walk Average $6\";
				" > ${TIME_RESULT_DISCRETE}

	eog ${TIME_RESULT_DISCRETE}
}

plot_together()
{
	gnuplot -e "set terminal jpeg large size 1600,750;
				set multiplot layout 2,2;

				set title \"Epochs Comparison (Continuous)\";
				set xlabel \"Key\";
				set ylabel \"Epochs to Synchronize\";
				set grid;
				set border 1;
				plot '${OUTPUT_EPOCHS_HEBBIAN_DAT}' with line linetype rgbcolor \"red\" linewidth 1 title \"Hebbian\",
				'${OUTPUT_EPOCHS_ANTI_HEBBIAN_DAT}' with line linetype rgbcolor \"blue\" linewidth 1 title \"Anti-Hebbian\",
				'${OUTPUT_EPOCHS_RANDOM_WALK_DAT}' with line linetype rgbcolor \"green\" linewidth 1 title \"Random Walk\";

				set title \"Epochs Comparison (Discrete)\";
				set xlabel \"Key\";
				set ylabel \"Epochs to Synchronize\";
				set grid;
				set border 1;
				plot '${OUTPUT_EPOCHS_HEBBIAN_DAT}' linetype rgbcolor \"red\" linewidth 1 title \"Hebbian\",
				'${OUTPUT_EPOCHS_ANTI_HEBBIAN_DAT}' linetype rgbcolor \"blue\" linewidth 1 title \"Anti-Hebbian\",
				'${OUTPUT_EPOCHS_RANDOM_WALK_DAT}' linetype rgbcolor \"green\" linewidth 1 title \"Random Walk\",
				$1 with line linetype rgbcolor \"red\" linewidth 2 title \"Hebbian Average $1\",
				$2 with line linetype rgbcolor \"blue\" linewidth 2 title \"Anti-Hebbian Average $2\",
				$3 with line linetype rgbcolor \"green\" linewidth 2 title \"Random-Walk Average $3\";

				set title \"Time Comparison (Continuous)\";
				set xlabel \"Key\";
				set ylabel \"Time for Generate each Key [microseconds]\";
				set grid;
				set border 1;
				plot '${OUTPUT_TIME_HEBBIAN_DAT}' with line linetype rgbcolor \"red\" linewidth 1 title \"Hebbian\",
				'${OUTPUT_TIME_ANTI_HEBBIAN_DAT}' with line linetype rgbcolor \"blue\" linewidth 1 title \"Anti-Hebbian\",
				'${OUTPUT_TIME_RANDOM_WALK_DAT}' with line linetype rgbcolor \"green\" linewidth 1 title \"Random Walk\";

				set title \"Time Comparison (Discrete)\";
				set xlabel \"Key\";
				set ylabel \"Time for Generate each Key [microseconds]\";
				set grid;
				set border 1;
				plot '${OUTPUT_TIME_HEBBIAN_DAT}' linetype rgbcolor \"red\" linewidth 1 title \"Hebbian\",
				'${OUTPUT_TIME_ANTI_HEBBIAN_DAT}' linetype rgbcolor \"blue\" linewidth 1 title \"Anti-Hebbian\",
				'${OUTPUT_TIME_RANDOM_WALK_DAT}' linetype rgbcolor \"green\" linewidth 1 title \"Random Walk\",
				$4 with line linetype rgbcolor \"red\" linewidth 2 title \"Hebbian Average $4\",
				$5 with line linetype rgbcolor \"blue\" linewidth 2 title \"Anti-Hebbian Average $5\",
				$6 with line linetype rgbcolor \"green\" linewidth 2 title \"Random-Walk Average $6\";

				unset multiplot;" > ${GENERAL_RESULT}

	eog ${GENERAL_RESULT}
}

# Main Loop

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ] || [ "$4" = "" ] || [ "$5" = ""  ] || [ "$6" = ""  ] || [ "$7" = ""  ]
then
	printf "\n"
	printf "Usage:\n"
	printf "./plot_comparison.sh <hebbian epochs average> <anti hebbian epochs average> <random walk epochs average> <hebbian time average> <anti hebbian time average> <random walk time average> <separated/together [0,1]>\n\n"
	exit 0;
fi

if [ $7 = 0 ]
then
	plot_separated $1 $2 $3 $4 $5 $6
else
	plot_together $1 $2 $3 $4 $5 $6
fi

exit 1;

