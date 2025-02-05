/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/05 06:43:59 by mahug             #+#    #+#             */
/*   Updated: 2025/02/05 06:44:01 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>

int	*ft_range(int min, int max);

void	print_range(int *range, int size)
{
	int	i;

	i = 0;
	while (i < size)
	{
		printf("%d", range[i]);
		if (i < size - 1)
			printf(" ");
		i++;
	}
	printf("\n");
}

int	main(int argc, char **argv)
{
	int	*range;
	int	min;
	int	max;
	int	size;

	if (argc != 3)
	{
		printf("Usage: %s <min> <max>\n", argv[0]);
		return (0);
	}
	min = atoi(argv[1]);
	max = atoi(argv[2]);
	range = ft_range(min, max);
	if (!range)
	{
		printf("Range from %d to %d is NULL\n", min, max);
		return (1);
	}
	size = max - min;
	print_range(range, size);
	free(range);
	return (0);
}
