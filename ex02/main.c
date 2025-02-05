/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/05 06:44:16 by mahug             #+#    #+#             */
/*   Updated: 2025/02/05 06:44:20 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>

int	ft_ultimate_range(int **range, int min, int max);

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

int	is_valid_size(int size, int min, int max)
{
	if (size == -1)
	{
		printf("Memory allocation failed\n");
		return (0);
	}
	if (size == 0)
	{
		printf("Range from %d to %d is NULL\n", min, max);
		return (0);
	}
	return (1);
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
	size = ft_ultimate_range(&range, min, max);
	if (!is_valid_size(size, min, max))
		return (1);
	print_range(range, size);
	free(range);
	return (0);
}
