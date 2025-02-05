/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/05 06:44:29 by mahug             #+#    #+#             */
/*   Updated: 2025/02/05 06:44:31 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>

char	*ft_strjoin(int size, char **strs, char *sep);

int	main(int argc, char **argv)
{
	char	*str;
	char	*sep;

	if (argc < 2)
	{
		printf("Usage: %s <separator> <string1> "
			"[<string2> ... <stringN>]\n", argv[0]);
		return (0);
	}
	sep = argv[1];
	str = ft_strjoin(argc - 2, argv + 2, sep);
	if (!str)
	{
		printf("Error: failed to allocate memory\n");
		return (1);
	}
	printf("%s\n", str);
	free(str);
	return (0);
}
