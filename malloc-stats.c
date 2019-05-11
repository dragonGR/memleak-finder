/*
 * malloc-stats.c
 * Copyright (C) 2019 Alex Tsanis
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#define _GNU_SOURCE
#include <malloc.h>
#include <stdio.h>
#include <assert.h>
#include <signal.h>

#define STAT_SIGNAL	SIGUSR2

/* Signal handler */
static void sighandler(int signo, siginfo_t *siginfo, void *context)
{
	malloc_stats();
}

static __attribute__((constructor))
void print_stats_init(void)
{
	/* Attach signal handler on STAT_SIGNAL */
	struct sigaction act;
	int ret;

	act.sa_sigaction = sighandler;
	act.sa_flags = SA_SIGINFO | SA_RESTART;
	sigemptyset(&act.sa_mask);
	ret = sigaction(STAT_SIGNAL, &act, NULL);
	assert(!ret);
}
