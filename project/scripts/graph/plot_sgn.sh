
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
 # Creation Time: 16:43:28
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

plot_sgn_graphic()
{
	gnuplot -e "set terminal jpeg;
				set xrange [-1.5:1.5];
				set yrange [-1.5:1.5];
				set xzeroaxis linetype -1;
				set yzeroaxis linetype -1;
				set title \"y = sgn(x)\";
				set key off;
				set grid;
				set border 1;
				set samples 400;
				plot sgn(x) with line linetype rgbcolor \"red\" linewidth 2" > sgn_preview.jpeg

	eog sgn_preview.jpeg
}

plot_sgn_raw()
{
	gnuplot -e "set terminal dumb;
				set xrange [-1.5:1.5];
				set yrange [-1.5:1.5];
				set xzeroaxis linetype -1;
				set yzeroaxis linetype -1;
				set title \"y = sgn(x)\";
				set key off;
				set grid;
				set border 1;
				set samples 400;
				plot sgn(x) with line linetype rgbcolor \"red\" linewidth 2"
}

if [ "$1" = "raw" ]
then
	plot_sgn_raw
	exit 1;
fi

if [ "$1" = "graphic" ]
then
	plot_sgn_graphic
	exit 1;
fi

printf "\n"
printf "Usage:\n"
printf "./plot_sgn.sh raw\n"
printf "./plot_sgn.sh graphic\n"
printf "\n"

exit 0;

