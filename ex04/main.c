/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/05 06:44:38 by mahug             #+#    #+#             */
/*   Updated: 2025/02/05 06:44:40 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>

char	*ft_convert_base(char *nbr, char *base_from, char *base_to);

int	main(int argc, char **argv)
{
	char	*result;

	if (argc != 4)
	{
		printf("Usage: %s <number> <base_from> <base_to>\n", argv[0]);
		return (0);
	}
	result = ft_convert_base(argv[1], argv[2], argv[3]);
	if (!result)
	{
		printf("Error: Invalid base or conversion failed.\n");
		return (1);
	}
	printf("%s\n", result);
	free(result);
	return (0);
}
