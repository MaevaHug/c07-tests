/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/05 06:44:52 by mahug             #+#    #+#             */
/*   Updated: 2025/02/05 06:44:54 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>

char	**ft_split(char *str, char *charset);

void	print_tokens(char **tokens)
{
	int	i;

	i = 0;
	while (tokens[i])
	{
		printf("[%s]", tokens[i]);
		i++;
	}
	printf("[%s]", tokens[i]);
	printf("\n");
}

void	free_tokens(char **tokens)
{
	int	i;

	i = 0;
	while (tokens[i])
	{
		free(tokens[i]);
		i++;
	}
	free(tokens);
}

int	main(int argc, char **argv)
{
	char	**tokens;

	if (argc != 3)
	{
		printf("Usage: %s <string> <charset>\n", argv[0]);
		return (0);
	}
	tokens = ft_split(argv[1], argv[2]);
	if (!tokens)
	{
		printf("Error: Memory allocation failed.\n");
		return (1);
	}
	print_tokens(tokens);
	free_tokens(tokens);
	return (0);
}
