#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int 
main(int argc, char *argv[])
{
	int parent_to_child[2];
	int child_to_parent[2];
	pipe(parent_to_child);
	pipe(child_to_parent);

	char c;
	int n;
	
	if (fork() == 0) { 
		// child
		close(child_to_parent[0]);
		close(parent_to_child[1]);
		n = read(parent_to_child[0], &c, 1);

		if (n != 1) {
			fprintf(2, "Child read error\n");
		}
		printf("%d: received ping\n", getpid());
		write(child_to_parent[1], &c, 1);

		close(parent_to_child[0]);
		close(child_to_parent[1]);
		
		exit(0);
	} else {
		// parent
		close(parent_to_child[0]);
		close(child_to_parent[1]);

		write(parent_to_child[1], &c, 1);
		n = read(child_to_parent[0], &c, 1);
			
		if (n != 1) {
			fprintf(2, "Parent read error\n");
		}

		printf("%d: received pong\n", getpid());
		close(parent_to_child[1]);
		close(child_to_parent[0]);
		
		wait(0);
		exit(0);
	}
}
