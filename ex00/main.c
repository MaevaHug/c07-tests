/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/05 06:43:23 by mahug             #+#    #+#             */
/*   Updated: 2025/02/05 06:43:25 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>

char	*ft_strdup(char *src);

void	print_with_nulls(char *str, unsigned int n, char *function_name)
{
	unsigned int	i;

	if (function_name)
		printf("%s: ", function_name);
	i = 0;
	while (i <= n)
	{
		if (str[i] == '\0')
			printf("\\0");
		else
			printf("%c", str[i]);
		i++;
	}
	printf("\n");
}

void	check_result(char *dup_libc, char *dup_ft, unsigned int len)
{
	if (strcmp(dup_libc, dup_ft) == 0 && dup_ft[len] == '\0')
		printf("OK\n");
	else
	{
		printf("KO\n");
		print_with_nulls(dup_libc, len, "strdup");
		print_with_nulls(dup_ft, len, "ft_strdup");
	}
}

int	main(int argc, char **argv)
{
	char			*dup_ft;
	char			*dup_libc;
	unsigned int	src_len;

	if (argc != 2)
	{
		printf("Usage: %s <string>\n", argv[0]);
		return (0);
	}
	src_len = strlen(argv[1]);
	dup_libc = strdup(argv[1]);
	dup_ft = ft_strdup(argv[1]);
	if (!dup_libc || !dup_ft)
	{
		printf("Memory allocation failed\n");
		free(dup_libc);
		free(dup_ft);
		return (1);
	}
	check_result(dup_libc, dup_ft, src_len);
	free(dup_libc);
	free(dup_ft);
	return (0);
}
