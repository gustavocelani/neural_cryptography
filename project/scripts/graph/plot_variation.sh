
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
 # Creation Date: 16/10/2018
 # Creation Time: 23:11:45
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

EPOCHS_FILE='../outputs/epochs.txt'
EPOCHS_DAT_FILE='../outputs/epochs.dat'

TIME_FILE='../outputs/time.txt'
TIME_DAT_FILE='../outputs/time.dat'

RESULT_GRAPH='../outputs/variation.jpeg'

if [ "$1" = "" ] || [ "$2" = "" ]
then
	printf "\n"
	printf "Usage:\n"
	printf "./plot_variation.sh <epochs average value> <time average value>\n\n"
	exit 0;
fi

cat -n ${EPOCHS_FILE} > ${EPOCHS_DAT_FILE}
cat -n ${TIME_FILE} > ${TIME_DAT_FILE}

gnuplot -e "set terminal jpeg large size 1600,750;
			set multiplot layout 2,2;

			set title \"Epochs Variation (Continuous)\";
			set xlabel \"Key\";
			set ylabel \"Epochs to Synchronize\";
			set grid;
			set border 1;
			plot '${EPOCHS_DAT_FILE}' with line linetype rgbcolor \"red\" linewidth 2 title \"Epochs\",
			$1 with line linetype rgbcolor \"blue\" linewidth 2 title \"Average $1\";

			set title \"Epochs Variation (Discrete)\";
			set xlabel \"Key\";
			set ylabel \"Epochs to Synchronize\";
			set grid;
			set border 1;
			plot '${EPOCHS_DAT_FILE}' title \"Epochs\",
			$1 with line linetype rgbcolor \"blue\" linewidth 2 title \"Average $1\";

			set title \"Time Variation (Continuous)\";
			set xlabel \"Key\";
			set ylabel \"Time for Generate each Key [microseconds]\";
			set grid;
			set border 1;
			plot '${TIME_DAT_FILE}' with line linetype rgbcolor \"red\" linewidth 2 title \"Time\",
			$2 with line linetype rgbcolor \"blue\" linewidth 2 title \"Average $2\";

			set title \"Time Variation (Discrete)\";
			set xlabel \"Key\";
			set ylabel \"Time for Generate each Key [microseconds]\";
			set grid;
			set border 1;
			plot '${TIME_DAT_FILE}' title \"Time\",
			$2 with line linetype rgbcolor \"blue\" linewidth 2 title \"Average $2\";

			unset multiplot;" > ${RESULT_GRAPH}

eog ${RESULT_GRAPH}

exit 1;

