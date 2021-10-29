
user/_pingpong:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int 
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
	int parent_to_child[2];
	int child_to_parent[2];
	pipe(parent_to_child);
   8:	fe840513          	addi	a0,s0,-24
   c:	00000097          	auipc	ra,0x0
  10:	3c8080e7          	jalr	968(ra) # 3d4 <pipe>
	pipe(child_to_parent);
  14:	fe040513          	addi	a0,s0,-32
  18:	00000097          	auipc	ra,0x0
  1c:	3bc080e7          	jalr	956(ra) # 3d4 <pipe>

	char c;
	int n;
	
	if (fork() == 0) { 
  20:	00000097          	auipc	ra,0x0
  24:	39c080e7          	jalr	924(ra) # 3bc <fork>
  28:	e951                	bnez	a0,bc <main+0xbc>
		// child
		close(child_to_parent[0]);
  2a:	fe042503          	lw	a0,-32(s0)
  2e:	00000097          	auipc	ra,0x0
  32:	3be080e7          	jalr	958(ra) # 3ec <close>
		close(parent_to_child[1]);
  36:	fec42503          	lw	a0,-20(s0)
  3a:	00000097          	auipc	ra,0x0
  3e:	3b2080e7          	jalr	946(ra) # 3ec <close>
		n = read(parent_to_child[0], &c, 1);
  42:	4605                	li	a2,1
  44:	fdf40593          	addi	a1,s0,-33
  48:	fe842503          	lw	a0,-24(s0)
  4c:	00000097          	auipc	ra,0x0
  50:	390080e7          	jalr	912(ra) # 3dc <read>

		if (n != 1) {
  54:	4785                	li	a5,1
  56:	04f51963          	bne	a0,a5,a8 <main+0xa8>
			fprintf(2, "Child read error\n");
		}
		printf("%d: received ping\n", getpid());
  5a:	00000097          	auipc	ra,0x0
  5e:	3ea080e7          	jalr	1002(ra) # 444 <getpid>
  62:	85aa                	mv	a1,a0
  64:	00001517          	auipc	a0,0x1
  68:	89450513          	addi	a0,a0,-1900 # 8f8 <malloc+0x102>
  6c:	00000097          	auipc	ra,0x0
  70:	6d2080e7          	jalr	1746(ra) # 73e <printf>
		write(child_to_parent[1], &c, 1);
  74:	4605                	li	a2,1
  76:	fdf40593          	addi	a1,s0,-33
  7a:	fe442503          	lw	a0,-28(s0)
  7e:	00000097          	auipc	ra,0x0
  82:	366080e7          	jalr	870(ra) # 3e4 <write>

		close(parent_to_child[0]);
  86:	fe842503          	lw	a0,-24(s0)
  8a:	00000097          	auipc	ra,0x0
  8e:	362080e7          	jalr	866(ra) # 3ec <close>
		close(child_to_parent[1]);
  92:	fe442503          	lw	a0,-28(s0)
  96:	00000097          	auipc	ra,0x0
  9a:	356080e7          	jalr	854(ra) # 3ec <close>
		
		exit(0);
  9e:	4501                	li	a0,0
  a0:	00000097          	auipc	ra,0x0
  a4:	324080e7          	jalr	804(ra) # 3c4 <exit>
			fprintf(2, "Child read error\n");
  a8:	00001597          	auipc	a1,0x1
  ac:	83858593          	addi	a1,a1,-1992 # 8e0 <malloc+0xea>
  b0:	4509                	li	a0,2
  b2:	00000097          	auipc	ra,0x0
  b6:	65e080e7          	jalr	1630(ra) # 710 <fprintf>
  ba:	b745                	j	5a <main+0x5a>
	} else {
		// parent
		close(parent_to_child[0]);
  bc:	fe842503          	lw	a0,-24(s0)
  c0:	00000097          	auipc	ra,0x0
  c4:	32c080e7          	jalr	812(ra) # 3ec <close>
		close(child_to_parent[1]);
  c8:	fe442503          	lw	a0,-28(s0)
  cc:	00000097          	auipc	ra,0x0
  d0:	320080e7          	jalr	800(ra) # 3ec <close>

		write(parent_to_child[1], &c, 1);
  d4:	4605                	li	a2,1
  d6:	fdf40593          	addi	a1,s0,-33
  da:	fec42503          	lw	a0,-20(s0)
  de:	00000097          	auipc	ra,0x0
  e2:	306080e7          	jalr	774(ra) # 3e4 <write>
		n = read(child_to_parent[0], &c, 1);
  e6:	4605                	li	a2,1
  e8:	fdf40593          	addi	a1,s0,-33
  ec:	fe042503          	lw	a0,-32(s0)
  f0:	00000097          	auipc	ra,0x0
  f4:	2ec080e7          	jalr	748(ra) # 3dc <read>
			
		if (n != 1) {
  f8:	4785                	li	a5,1
  fa:	04f51563          	bne	a0,a5,144 <main+0x144>
			fprintf(2, "Parent read error\n");
		}

		printf("%d: received pong\n", getpid());
  fe:	00000097          	auipc	ra,0x0
 102:	346080e7          	jalr	838(ra) # 444 <getpid>
 106:	85aa                	mv	a1,a0
 108:	00001517          	auipc	a0,0x1
 10c:	82050513          	addi	a0,a0,-2016 # 928 <malloc+0x132>
 110:	00000097          	auipc	ra,0x0
 114:	62e080e7          	jalr	1582(ra) # 73e <printf>
		close(parent_to_child[1]);
 118:	fec42503          	lw	a0,-20(s0)
 11c:	00000097          	auipc	ra,0x0
 120:	2d0080e7          	jalr	720(ra) # 3ec <close>
		close(child_to_parent[0]);
 124:	fe042503          	lw	a0,-32(s0)
 128:	00000097          	auipc	ra,0x0
 12c:	2c4080e7          	jalr	708(ra) # 3ec <close>
		
		wait(0);
 130:	4501                	li	a0,0
 132:	00000097          	auipc	ra,0x0
 136:	29a080e7          	jalr	666(ra) # 3cc <wait>
		exit(0);
 13a:	4501                	li	a0,0
 13c:	00000097          	auipc	ra,0x0
 140:	288080e7          	jalr	648(ra) # 3c4 <exit>
			fprintf(2, "Parent read error\n");
 144:	00000597          	auipc	a1,0x0
 148:	7cc58593          	addi	a1,a1,1996 # 910 <malloc+0x11a>
 14c:	4509                	li	a0,2
 14e:	00000097          	auipc	ra,0x0
 152:	5c2080e7          	jalr	1474(ra) # 710 <fprintf>
 156:	b765                	j	fe <main+0xfe>

0000000000000158 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 158:	1141                	addi	sp,sp,-16
 15a:	e422                	sd	s0,8(sp)
 15c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 15e:	87aa                	mv	a5,a0
 160:	0585                	addi	a1,a1,1
 162:	0785                	addi	a5,a5,1
 164:	fff5c703          	lbu	a4,-1(a1)
 168:	fee78fa3          	sb	a4,-1(a5)
 16c:	fb75                	bnez	a4,160 <strcpy+0x8>
    ;
  return os;
}
 16e:	6422                	ld	s0,8(sp)
 170:	0141                	addi	sp,sp,16
 172:	8082                	ret

0000000000000174 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 174:	1141                	addi	sp,sp,-16
 176:	e422                	sd	s0,8(sp)
 178:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 17a:	00054783          	lbu	a5,0(a0)
 17e:	cb91                	beqz	a5,192 <strcmp+0x1e>
 180:	0005c703          	lbu	a4,0(a1)
 184:	00f71763          	bne	a4,a5,192 <strcmp+0x1e>
    p++, q++;
 188:	0505                	addi	a0,a0,1
 18a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 18c:	00054783          	lbu	a5,0(a0)
 190:	fbe5                	bnez	a5,180 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 192:	0005c503          	lbu	a0,0(a1)
}
 196:	40a7853b          	subw	a0,a5,a0
 19a:	6422                	ld	s0,8(sp)
 19c:	0141                	addi	sp,sp,16
 19e:	8082                	ret

00000000000001a0 <strlen>:

uint
strlen(const char *s)
{
 1a0:	1141                	addi	sp,sp,-16
 1a2:	e422                	sd	s0,8(sp)
 1a4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1a6:	00054783          	lbu	a5,0(a0)
 1aa:	cf91                	beqz	a5,1c6 <strlen+0x26>
 1ac:	0505                	addi	a0,a0,1
 1ae:	87aa                	mv	a5,a0
 1b0:	4685                	li	a3,1
 1b2:	9e89                	subw	a3,a3,a0
 1b4:	00f6853b          	addw	a0,a3,a5
 1b8:	0785                	addi	a5,a5,1
 1ba:	fff7c703          	lbu	a4,-1(a5)
 1be:	fb7d                	bnez	a4,1b4 <strlen+0x14>
    ;
  return n;
}
 1c0:	6422                	ld	s0,8(sp)
 1c2:	0141                	addi	sp,sp,16
 1c4:	8082                	ret
  for(n = 0; s[n]; n++)
 1c6:	4501                	li	a0,0
 1c8:	bfe5                	j	1c0 <strlen+0x20>

00000000000001ca <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ca:	1141                	addi	sp,sp,-16
 1cc:	e422                	sd	s0,8(sp)
 1ce:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1d0:	ca19                	beqz	a2,1e6 <memset+0x1c>
 1d2:	87aa                	mv	a5,a0
 1d4:	1602                	slli	a2,a2,0x20
 1d6:	9201                	srli	a2,a2,0x20
 1d8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1dc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1e0:	0785                	addi	a5,a5,1
 1e2:	fee79de3          	bne	a5,a4,1dc <memset+0x12>
  }
  return dst;
}
 1e6:	6422                	ld	s0,8(sp)
 1e8:	0141                	addi	sp,sp,16
 1ea:	8082                	ret

00000000000001ec <strchr>:

char*
strchr(const char *s, char c)
{
 1ec:	1141                	addi	sp,sp,-16
 1ee:	e422                	sd	s0,8(sp)
 1f0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1f2:	00054783          	lbu	a5,0(a0)
 1f6:	cb99                	beqz	a5,20c <strchr+0x20>
    if(*s == c)
 1f8:	00f58763          	beq	a1,a5,206 <strchr+0x1a>
  for(; *s; s++)
 1fc:	0505                	addi	a0,a0,1
 1fe:	00054783          	lbu	a5,0(a0)
 202:	fbfd                	bnez	a5,1f8 <strchr+0xc>
      return (char*)s;
  return 0;
 204:	4501                	li	a0,0
}
 206:	6422                	ld	s0,8(sp)
 208:	0141                	addi	sp,sp,16
 20a:	8082                	ret
  return 0;
 20c:	4501                	li	a0,0
 20e:	bfe5                	j	206 <strchr+0x1a>

0000000000000210 <gets>:

char*
gets(char *buf, int max)
{
 210:	711d                	addi	sp,sp,-96
 212:	ec86                	sd	ra,88(sp)
 214:	e8a2                	sd	s0,80(sp)
 216:	e4a6                	sd	s1,72(sp)
 218:	e0ca                	sd	s2,64(sp)
 21a:	fc4e                	sd	s3,56(sp)
 21c:	f852                	sd	s4,48(sp)
 21e:	f456                	sd	s5,40(sp)
 220:	f05a                	sd	s6,32(sp)
 222:	ec5e                	sd	s7,24(sp)
 224:	1080                	addi	s0,sp,96
 226:	8baa                	mv	s7,a0
 228:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22a:	892a                	mv	s2,a0
 22c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 22e:	4aa9                	li	s5,10
 230:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 232:	89a6                	mv	s3,s1
 234:	2485                	addiw	s1,s1,1
 236:	0344d863          	bge	s1,s4,266 <gets+0x56>
    cc = read(0, &c, 1);
 23a:	4605                	li	a2,1
 23c:	faf40593          	addi	a1,s0,-81
 240:	4501                	li	a0,0
 242:	00000097          	auipc	ra,0x0
 246:	19a080e7          	jalr	410(ra) # 3dc <read>
    if(cc < 1)
 24a:	00a05e63          	blez	a0,266 <gets+0x56>
    buf[i++] = c;
 24e:	faf44783          	lbu	a5,-81(s0)
 252:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 256:	01578763          	beq	a5,s5,264 <gets+0x54>
 25a:	0905                	addi	s2,s2,1
 25c:	fd679be3          	bne	a5,s6,232 <gets+0x22>
  for(i=0; i+1 < max; ){
 260:	89a6                	mv	s3,s1
 262:	a011                	j	266 <gets+0x56>
 264:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 266:	99de                	add	s3,s3,s7
 268:	00098023          	sb	zero,0(s3)
  return buf;
}
 26c:	855e                	mv	a0,s7
 26e:	60e6                	ld	ra,88(sp)
 270:	6446                	ld	s0,80(sp)
 272:	64a6                	ld	s1,72(sp)
 274:	6906                	ld	s2,64(sp)
 276:	79e2                	ld	s3,56(sp)
 278:	7a42                	ld	s4,48(sp)
 27a:	7aa2                	ld	s5,40(sp)
 27c:	7b02                	ld	s6,32(sp)
 27e:	6be2                	ld	s7,24(sp)
 280:	6125                	addi	sp,sp,96
 282:	8082                	ret

0000000000000284 <stat>:

int
stat(const char *n, struct stat *st)
{
 284:	1101                	addi	sp,sp,-32
 286:	ec06                	sd	ra,24(sp)
 288:	e822                	sd	s0,16(sp)
 28a:	e426                	sd	s1,8(sp)
 28c:	e04a                	sd	s2,0(sp)
 28e:	1000                	addi	s0,sp,32
 290:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 292:	4581                	li	a1,0
 294:	00000097          	auipc	ra,0x0
 298:	170080e7          	jalr	368(ra) # 404 <open>
  if(fd < 0)
 29c:	02054563          	bltz	a0,2c6 <stat+0x42>
 2a0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2a2:	85ca                	mv	a1,s2
 2a4:	00000097          	auipc	ra,0x0
 2a8:	178080e7          	jalr	376(ra) # 41c <fstat>
 2ac:	892a                	mv	s2,a0
  close(fd);
 2ae:	8526                	mv	a0,s1
 2b0:	00000097          	auipc	ra,0x0
 2b4:	13c080e7          	jalr	316(ra) # 3ec <close>
  return r;
}
 2b8:	854a                	mv	a0,s2
 2ba:	60e2                	ld	ra,24(sp)
 2bc:	6442                	ld	s0,16(sp)
 2be:	64a2                	ld	s1,8(sp)
 2c0:	6902                	ld	s2,0(sp)
 2c2:	6105                	addi	sp,sp,32
 2c4:	8082                	ret
    return -1;
 2c6:	597d                	li	s2,-1
 2c8:	bfc5                	j	2b8 <stat+0x34>

00000000000002ca <atoi>:

int
atoi(const char *s)
{
 2ca:	1141                	addi	sp,sp,-16
 2cc:	e422                	sd	s0,8(sp)
 2ce:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d0:	00054683          	lbu	a3,0(a0)
 2d4:	fd06879b          	addiw	a5,a3,-48
 2d8:	0ff7f793          	zext.b	a5,a5
 2dc:	4625                	li	a2,9
 2de:	02f66863          	bltu	a2,a5,30e <atoi+0x44>
 2e2:	872a                	mv	a4,a0
  n = 0;
 2e4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2e6:	0705                	addi	a4,a4,1
 2e8:	0025179b          	slliw	a5,a0,0x2
 2ec:	9fa9                	addw	a5,a5,a0
 2ee:	0017979b          	slliw	a5,a5,0x1
 2f2:	9fb5                	addw	a5,a5,a3
 2f4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2f8:	00074683          	lbu	a3,0(a4)
 2fc:	fd06879b          	addiw	a5,a3,-48
 300:	0ff7f793          	zext.b	a5,a5
 304:	fef671e3          	bgeu	a2,a5,2e6 <atoi+0x1c>
  return n;
}
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	addi	sp,sp,16
 30c:	8082                	ret
  n = 0;
 30e:	4501                	li	a0,0
 310:	bfe5                	j	308 <atoi+0x3e>

0000000000000312 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 312:	1141                	addi	sp,sp,-16
 314:	e422                	sd	s0,8(sp)
 316:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 318:	02b57463          	bgeu	a0,a1,340 <memmove+0x2e>
    while(n-- > 0)
 31c:	00c05f63          	blez	a2,33a <memmove+0x28>
 320:	1602                	slli	a2,a2,0x20
 322:	9201                	srli	a2,a2,0x20
 324:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 328:	872a                	mv	a4,a0
      *dst++ = *src++;
 32a:	0585                	addi	a1,a1,1
 32c:	0705                	addi	a4,a4,1
 32e:	fff5c683          	lbu	a3,-1(a1)
 332:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 336:	fee79ae3          	bne	a5,a4,32a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 33a:	6422                	ld	s0,8(sp)
 33c:	0141                	addi	sp,sp,16
 33e:	8082                	ret
    dst += n;
 340:	00c50733          	add	a4,a0,a2
    src += n;
 344:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 346:	fec05ae3          	blez	a2,33a <memmove+0x28>
 34a:	fff6079b          	addiw	a5,a2,-1
 34e:	1782                	slli	a5,a5,0x20
 350:	9381                	srli	a5,a5,0x20
 352:	fff7c793          	not	a5,a5
 356:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 358:	15fd                	addi	a1,a1,-1
 35a:	177d                	addi	a4,a4,-1
 35c:	0005c683          	lbu	a3,0(a1)
 360:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 364:	fee79ae3          	bne	a5,a4,358 <memmove+0x46>
 368:	bfc9                	j	33a <memmove+0x28>

000000000000036a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 36a:	1141                	addi	sp,sp,-16
 36c:	e422                	sd	s0,8(sp)
 36e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 370:	ca05                	beqz	a2,3a0 <memcmp+0x36>
 372:	fff6069b          	addiw	a3,a2,-1
 376:	1682                	slli	a3,a3,0x20
 378:	9281                	srli	a3,a3,0x20
 37a:	0685                	addi	a3,a3,1
 37c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 37e:	00054783          	lbu	a5,0(a0)
 382:	0005c703          	lbu	a4,0(a1)
 386:	00e79863          	bne	a5,a4,396 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 38a:	0505                	addi	a0,a0,1
    p2++;
 38c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 38e:	fed518e3          	bne	a0,a3,37e <memcmp+0x14>
  }
  return 0;
 392:	4501                	li	a0,0
 394:	a019                	j	39a <memcmp+0x30>
      return *p1 - *p2;
 396:	40e7853b          	subw	a0,a5,a4
}
 39a:	6422                	ld	s0,8(sp)
 39c:	0141                	addi	sp,sp,16
 39e:	8082                	ret
  return 0;
 3a0:	4501                	li	a0,0
 3a2:	bfe5                	j	39a <memcmp+0x30>

00000000000003a4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3a4:	1141                	addi	sp,sp,-16
 3a6:	e406                	sd	ra,8(sp)
 3a8:	e022                	sd	s0,0(sp)
 3aa:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3ac:	00000097          	auipc	ra,0x0
 3b0:	f66080e7          	jalr	-154(ra) # 312 <memmove>
}
 3b4:	60a2                	ld	ra,8(sp)
 3b6:	6402                	ld	s0,0(sp)
 3b8:	0141                	addi	sp,sp,16
 3ba:	8082                	ret

00000000000003bc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3bc:	4885                	li	a7,1
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3c4:	4889                	li	a7,2
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <wait>:
.global wait
wait:
 li a7, SYS_wait
 3cc:	488d                	li	a7,3
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3d4:	4891                	li	a7,4
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <read>:
.global read
read:
 li a7, SYS_read
 3dc:	4895                	li	a7,5
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <write>:
.global write
write:
 li a7, SYS_write
 3e4:	48c1                	li	a7,16
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <close>:
.global close
close:
 li a7, SYS_close
 3ec:	48d5                	li	a7,21
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3f4:	4899                	li	a7,6
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <exec>:
.global exec
exec:
 li a7, SYS_exec
 3fc:	489d                	li	a7,7
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <open>:
.global open
open:
 li a7, SYS_open
 404:	48bd                	li	a7,15
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 40c:	48c5                	li	a7,17
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 414:	48c9                	li	a7,18
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 41c:	48a1                	li	a7,8
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <link>:
.global link
link:
 li a7, SYS_link
 424:	48cd                	li	a7,19
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 42c:	48d1                	li	a7,20
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 434:	48a5                	li	a7,9
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <dup>:
.global dup
dup:
 li a7, SYS_dup
 43c:	48a9                	li	a7,10
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 444:	48ad                	li	a7,11
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 44c:	48b1                	li	a7,12
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 454:	48b5                	li	a7,13
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 45c:	48b9                	li	a7,14
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 464:	1101                	addi	sp,sp,-32
 466:	ec06                	sd	ra,24(sp)
 468:	e822                	sd	s0,16(sp)
 46a:	1000                	addi	s0,sp,32
 46c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 470:	4605                	li	a2,1
 472:	fef40593          	addi	a1,s0,-17
 476:	00000097          	auipc	ra,0x0
 47a:	f6e080e7          	jalr	-146(ra) # 3e4 <write>
}
 47e:	60e2                	ld	ra,24(sp)
 480:	6442                	ld	s0,16(sp)
 482:	6105                	addi	sp,sp,32
 484:	8082                	ret

0000000000000486 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 486:	7139                	addi	sp,sp,-64
 488:	fc06                	sd	ra,56(sp)
 48a:	f822                	sd	s0,48(sp)
 48c:	f426                	sd	s1,40(sp)
 48e:	f04a                	sd	s2,32(sp)
 490:	ec4e                	sd	s3,24(sp)
 492:	0080                	addi	s0,sp,64
 494:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 496:	c299                	beqz	a3,49c <printint+0x16>
 498:	0805c963          	bltz	a1,52a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 49c:	2581                	sext.w	a1,a1
  neg = 0;
 49e:	4881                	li	a7,0
 4a0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4a4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4a6:	2601                	sext.w	a2,a2
 4a8:	00000517          	auipc	a0,0x0
 4ac:	4f850513          	addi	a0,a0,1272 # 9a0 <digits>
 4b0:	883a                	mv	a6,a4
 4b2:	2705                	addiw	a4,a4,1
 4b4:	02c5f7bb          	remuw	a5,a1,a2
 4b8:	1782                	slli	a5,a5,0x20
 4ba:	9381                	srli	a5,a5,0x20
 4bc:	97aa                	add	a5,a5,a0
 4be:	0007c783          	lbu	a5,0(a5)
 4c2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4c6:	0005879b          	sext.w	a5,a1
 4ca:	02c5d5bb          	divuw	a1,a1,a2
 4ce:	0685                	addi	a3,a3,1
 4d0:	fec7f0e3          	bgeu	a5,a2,4b0 <printint+0x2a>
  if(neg)
 4d4:	00088c63          	beqz	a7,4ec <printint+0x66>
    buf[i++] = '-';
 4d8:	fd070793          	addi	a5,a4,-48
 4dc:	00878733          	add	a4,a5,s0
 4e0:	02d00793          	li	a5,45
 4e4:	fef70823          	sb	a5,-16(a4)
 4e8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4ec:	02e05863          	blez	a4,51c <printint+0x96>
 4f0:	fc040793          	addi	a5,s0,-64
 4f4:	00e78933          	add	s2,a5,a4
 4f8:	fff78993          	addi	s3,a5,-1
 4fc:	99ba                	add	s3,s3,a4
 4fe:	377d                	addiw	a4,a4,-1
 500:	1702                	slli	a4,a4,0x20
 502:	9301                	srli	a4,a4,0x20
 504:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 508:	fff94583          	lbu	a1,-1(s2)
 50c:	8526                	mv	a0,s1
 50e:	00000097          	auipc	ra,0x0
 512:	f56080e7          	jalr	-170(ra) # 464 <putc>
  while(--i >= 0)
 516:	197d                	addi	s2,s2,-1
 518:	ff3918e3          	bne	s2,s3,508 <printint+0x82>
}
 51c:	70e2                	ld	ra,56(sp)
 51e:	7442                	ld	s0,48(sp)
 520:	74a2                	ld	s1,40(sp)
 522:	7902                	ld	s2,32(sp)
 524:	69e2                	ld	s3,24(sp)
 526:	6121                	addi	sp,sp,64
 528:	8082                	ret
    x = -xx;
 52a:	40b005bb          	negw	a1,a1
    neg = 1;
 52e:	4885                	li	a7,1
    x = -xx;
 530:	bf85                	j	4a0 <printint+0x1a>

0000000000000532 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 532:	7119                	addi	sp,sp,-128
 534:	fc86                	sd	ra,120(sp)
 536:	f8a2                	sd	s0,112(sp)
 538:	f4a6                	sd	s1,104(sp)
 53a:	f0ca                	sd	s2,96(sp)
 53c:	ecce                	sd	s3,88(sp)
 53e:	e8d2                	sd	s4,80(sp)
 540:	e4d6                	sd	s5,72(sp)
 542:	e0da                	sd	s6,64(sp)
 544:	fc5e                	sd	s7,56(sp)
 546:	f862                	sd	s8,48(sp)
 548:	f466                	sd	s9,40(sp)
 54a:	f06a                	sd	s10,32(sp)
 54c:	ec6e                	sd	s11,24(sp)
 54e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 550:	0005c903          	lbu	s2,0(a1)
 554:	18090f63          	beqz	s2,6f2 <vprintf+0x1c0>
 558:	8aaa                	mv	s5,a0
 55a:	8b32                	mv	s6,a2
 55c:	00158493          	addi	s1,a1,1
  state = 0;
 560:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 562:	02500a13          	li	s4,37
 566:	4c55                	li	s8,21
 568:	00000c97          	auipc	s9,0x0
 56c:	3e0c8c93          	addi	s9,s9,992 # 948 <malloc+0x152>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 570:	02800d93          	li	s11,40
  putc(fd, 'x');
 574:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 576:	00000b97          	auipc	s7,0x0
 57a:	42ab8b93          	addi	s7,s7,1066 # 9a0 <digits>
 57e:	a839                	j	59c <vprintf+0x6a>
        putc(fd, c);
 580:	85ca                	mv	a1,s2
 582:	8556                	mv	a0,s5
 584:	00000097          	auipc	ra,0x0
 588:	ee0080e7          	jalr	-288(ra) # 464 <putc>
 58c:	a019                	j	592 <vprintf+0x60>
    } else if(state == '%'){
 58e:	01498d63          	beq	s3,s4,5a8 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 592:	0485                	addi	s1,s1,1
 594:	fff4c903          	lbu	s2,-1(s1)
 598:	14090d63          	beqz	s2,6f2 <vprintf+0x1c0>
    if(state == 0){
 59c:	fe0999e3          	bnez	s3,58e <vprintf+0x5c>
      if(c == '%'){
 5a0:	ff4910e3          	bne	s2,s4,580 <vprintf+0x4e>
        state = '%';
 5a4:	89d2                	mv	s3,s4
 5a6:	b7f5                	j	592 <vprintf+0x60>
      if(c == 'd'){
 5a8:	11490c63          	beq	s2,s4,6c0 <vprintf+0x18e>
 5ac:	f9d9079b          	addiw	a5,s2,-99
 5b0:	0ff7f793          	zext.b	a5,a5
 5b4:	10fc6e63          	bltu	s8,a5,6d0 <vprintf+0x19e>
 5b8:	f9d9079b          	addiw	a5,s2,-99
 5bc:	0ff7f713          	zext.b	a4,a5
 5c0:	10ec6863          	bltu	s8,a4,6d0 <vprintf+0x19e>
 5c4:	00271793          	slli	a5,a4,0x2
 5c8:	97e6                	add	a5,a5,s9
 5ca:	439c                	lw	a5,0(a5)
 5cc:	97e6                	add	a5,a5,s9
 5ce:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5d0:	008b0913          	addi	s2,s6,8
 5d4:	4685                	li	a3,1
 5d6:	4629                	li	a2,10
 5d8:	000b2583          	lw	a1,0(s6)
 5dc:	8556                	mv	a0,s5
 5de:	00000097          	auipc	ra,0x0
 5e2:	ea8080e7          	jalr	-344(ra) # 486 <printint>
 5e6:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5e8:	4981                	li	s3,0
 5ea:	b765                	j	592 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ec:	008b0913          	addi	s2,s6,8
 5f0:	4681                	li	a3,0
 5f2:	4629                	li	a2,10
 5f4:	000b2583          	lw	a1,0(s6)
 5f8:	8556                	mv	a0,s5
 5fa:	00000097          	auipc	ra,0x0
 5fe:	e8c080e7          	jalr	-372(ra) # 486 <printint>
 602:	8b4a                	mv	s6,s2
      state = 0;
 604:	4981                	li	s3,0
 606:	b771                	j	592 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 608:	008b0913          	addi	s2,s6,8
 60c:	4681                	li	a3,0
 60e:	866a                	mv	a2,s10
 610:	000b2583          	lw	a1,0(s6)
 614:	8556                	mv	a0,s5
 616:	00000097          	auipc	ra,0x0
 61a:	e70080e7          	jalr	-400(ra) # 486 <printint>
 61e:	8b4a                	mv	s6,s2
      state = 0;
 620:	4981                	li	s3,0
 622:	bf85                	j	592 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 624:	008b0793          	addi	a5,s6,8
 628:	f8f43423          	sd	a5,-120(s0)
 62c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 630:	03000593          	li	a1,48
 634:	8556                	mv	a0,s5
 636:	00000097          	auipc	ra,0x0
 63a:	e2e080e7          	jalr	-466(ra) # 464 <putc>
  putc(fd, 'x');
 63e:	07800593          	li	a1,120
 642:	8556                	mv	a0,s5
 644:	00000097          	auipc	ra,0x0
 648:	e20080e7          	jalr	-480(ra) # 464 <putc>
 64c:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 64e:	03c9d793          	srli	a5,s3,0x3c
 652:	97de                	add	a5,a5,s7
 654:	0007c583          	lbu	a1,0(a5)
 658:	8556                	mv	a0,s5
 65a:	00000097          	auipc	ra,0x0
 65e:	e0a080e7          	jalr	-502(ra) # 464 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 662:	0992                	slli	s3,s3,0x4
 664:	397d                	addiw	s2,s2,-1
 666:	fe0914e3          	bnez	s2,64e <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 66a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 66e:	4981                	li	s3,0
 670:	b70d                	j	592 <vprintf+0x60>
        s = va_arg(ap, char*);
 672:	008b0913          	addi	s2,s6,8
 676:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 67a:	02098163          	beqz	s3,69c <vprintf+0x16a>
        while(*s != 0){
 67e:	0009c583          	lbu	a1,0(s3)
 682:	c5ad                	beqz	a1,6ec <vprintf+0x1ba>
          putc(fd, *s);
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	dde080e7          	jalr	-546(ra) # 464 <putc>
          s++;
 68e:	0985                	addi	s3,s3,1
        while(*s != 0){
 690:	0009c583          	lbu	a1,0(s3)
 694:	f9e5                	bnez	a1,684 <vprintf+0x152>
        s = va_arg(ap, char*);
 696:	8b4a                	mv	s6,s2
      state = 0;
 698:	4981                	li	s3,0
 69a:	bde5                	j	592 <vprintf+0x60>
          s = "(null)";
 69c:	00000997          	auipc	s3,0x0
 6a0:	2a498993          	addi	s3,s3,676 # 940 <malloc+0x14a>
        while(*s != 0){
 6a4:	85ee                	mv	a1,s11
 6a6:	bff9                	j	684 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 6a8:	008b0913          	addi	s2,s6,8
 6ac:	000b4583          	lbu	a1,0(s6)
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	db2080e7          	jalr	-590(ra) # 464 <putc>
 6ba:	8b4a                	mv	s6,s2
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	bdd1                	j	592 <vprintf+0x60>
        putc(fd, c);
 6c0:	85d2                	mv	a1,s4
 6c2:	8556                	mv	a0,s5
 6c4:	00000097          	auipc	ra,0x0
 6c8:	da0080e7          	jalr	-608(ra) # 464 <putc>
      state = 0;
 6cc:	4981                	li	s3,0
 6ce:	b5d1                	j	592 <vprintf+0x60>
        putc(fd, '%');
 6d0:	85d2                	mv	a1,s4
 6d2:	8556                	mv	a0,s5
 6d4:	00000097          	auipc	ra,0x0
 6d8:	d90080e7          	jalr	-624(ra) # 464 <putc>
        putc(fd, c);
 6dc:	85ca                	mv	a1,s2
 6de:	8556                	mv	a0,s5
 6e0:	00000097          	auipc	ra,0x0
 6e4:	d84080e7          	jalr	-636(ra) # 464 <putc>
      state = 0;
 6e8:	4981                	li	s3,0
 6ea:	b565                	j	592 <vprintf+0x60>
        s = va_arg(ap, char*);
 6ec:	8b4a                	mv	s6,s2
      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	b54d                	j	592 <vprintf+0x60>
    }
  }
}
 6f2:	70e6                	ld	ra,120(sp)
 6f4:	7446                	ld	s0,112(sp)
 6f6:	74a6                	ld	s1,104(sp)
 6f8:	7906                	ld	s2,96(sp)
 6fa:	69e6                	ld	s3,88(sp)
 6fc:	6a46                	ld	s4,80(sp)
 6fe:	6aa6                	ld	s5,72(sp)
 700:	6b06                	ld	s6,64(sp)
 702:	7be2                	ld	s7,56(sp)
 704:	7c42                	ld	s8,48(sp)
 706:	7ca2                	ld	s9,40(sp)
 708:	7d02                	ld	s10,32(sp)
 70a:	6de2                	ld	s11,24(sp)
 70c:	6109                	addi	sp,sp,128
 70e:	8082                	ret

0000000000000710 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 710:	715d                	addi	sp,sp,-80
 712:	ec06                	sd	ra,24(sp)
 714:	e822                	sd	s0,16(sp)
 716:	1000                	addi	s0,sp,32
 718:	e010                	sd	a2,0(s0)
 71a:	e414                	sd	a3,8(s0)
 71c:	e818                	sd	a4,16(s0)
 71e:	ec1c                	sd	a5,24(s0)
 720:	03043023          	sd	a6,32(s0)
 724:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 728:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 72c:	8622                	mv	a2,s0
 72e:	00000097          	auipc	ra,0x0
 732:	e04080e7          	jalr	-508(ra) # 532 <vprintf>
}
 736:	60e2                	ld	ra,24(sp)
 738:	6442                	ld	s0,16(sp)
 73a:	6161                	addi	sp,sp,80
 73c:	8082                	ret

000000000000073e <printf>:

void
printf(const char *fmt, ...)
{
 73e:	711d                	addi	sp,sp,-96
 740:	ec06                	sd	ra,24(sp)
 742:	e822                	sd	s0,16(sp)
 744:	1000                	addi	s0,sp,32
 746:	e40c                	sd	a1,8(s0)
 748:	e810                	sd	a2,16(s0)
 74a:	ec14                	sd	a3,24(s0)
 74c:	f018                	sd	a4,32(s0)
 74e:	f41c                	sd	a5,40(s0)
 750:	03043823          	sd	a6,48(s0)
 754:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 758:	00840613          	addi	a2,s0,8
 75c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 760:	85aa                	mv	a1,a0
 762:	4505                	li	a0,1
 764:	00000097          	auipc	ra,0x0
 768:	dce080e7          	jalr	-562(ra) # 532 <vprintf>
}
 76c:	60e2                	ld	ra,24(sp)
 76e:	6442                	ld	s0,16(sp)
 770:	6125                	addi	sp,sp,96
 772:	8082                	ret

0000000000000774 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 774:	1141                	addi	sp,sp,-16
 776:	e422                	sd	s0,8(sp)
 778:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 77a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77e:	00000797          	auipc	a5,0x0
 782:	23a7b783          	ld	a5,570(a5) # 9b8 <freep>
 786:	a02d                	j	7b0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 788:	4618                	lw	a4,8(a2)
 78a:	9f2d                	addw	a4,a4,a1
 78c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 790:	6398                	ld	a4,0(a5)
 792:	6310                	ld	a2,0(a4)
 794:	a83d                	j	7d2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 796:	ff852703          	lw	a4,-8(a0)
 79a:	9f31                	addw	a4,a4,a2
 79c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 79e:	ff053683          	ld	a3,-16(a0)
 7a2:	a091                	j	7e6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a4:	6398                	ld	a4,0(a5)
 7a6:	00e7e463          	bltu	a5,a4,7ae <free+0x3a>
 7aa:	00e6ea63          	bltu	a3,a4,7be <free+0x4a>
{
 7ae:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b0:	fed7fae3          	bgeu	a5,a3,7a4 <free+0x30>
 7b4:	6398                	ld	a4,0(a5)
 7b6:	00e6e463          	bltu	a3,a4,7be <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ba:	fee7eae3          	bltu	a5,a4,7ae <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7be:	ff852583          	lw	a1,-8(a0)
 7c2:	6390                	ld	a2,0(a5)
 7c4:	02059813          	slli	a6,a1,0x20
 7c8:	01c85713          	srli	a4,a6,0x1c
 7cc:	9736                	add	a4,a4,a3
 7ce:	fae60de3          	beq	a2,a4,788 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7d2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7d6:	4790                	lw	a2,8(a5)
 7d8:	02061593          	slli	a1,a2,0x20
 7dc:	01c5d713          	srli	a4,a1,0x1c
 7e0:	973e                	add	a4,a4,a5
 7e2:	fae68ae3          	beq	a3,a4,796 <free+0x22>
    p->s.ptr = bp->s.ptr;
 7e6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7e8:	00000717          	auipc	a4,0x0
 7ec:	1cf73823          	sd	a5,464(a4) # 9b8 <freep>
}
 7f0:	6422                	ld	s0,8(sp)
 7f2:	0141                	addi	sp,sp,16
 7f4:	8082                	ret

00000000000007f6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f6:	7139                	addi	sp,sp,-64
 7f8:	fc06                	sd	ra,56(sp)
 7fa:	f822                	sd	s0,48(sp)
 7fc:	f426                	sd	s1,40(sp)
 7fe:	f04a                	sd	s2,32(sp)
 800:	ec4e                	sd	s3,24(sp)
 802:	e852                	sd	s4,16(sp)
 804:	e456                	sd	s5,8(sp)
 806:	e05a                	sd	s6,0(sp)
 808:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 80a:	02051493          	slli	s1,a0,0x20
 80e:	9081                	srli	s1,s1,0x20
 810:	04bd                	addi	s1,s1,15
 812:	8091                	srli	s1,s1,0x4
 814:	0014899b          	addiw	s3,s1,1
 818:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 81a:	00000517          	auipc	a0,0x0
 81e:	19e53503          	ld	a0,414(a0) # 9b8 <freep>
 822:	c515                	beqz	a0,84e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 824:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 826:	4798                	lw	a4,8(a5)
 828:	02977f63          	bgeu	a4,s1,866 <malloc+0x70>
 82c:	8a4e                	mv	s4,s3
 82e:	0009871b          	sext.w	a4,s3
 832:	6685                	lui	a3,0x1
 834:	00d77363          	bgeu	a4,a3,83a <malloc+0x44>
 838:	6a05                	lui	s4,0x1
 83a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 83e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 842:	00000917          	auipc	s2,0x0
 846:	17690913          	addi	s2,s2,374 # 9b8 <freep>
  if(p == (char*)-1)
 84a:	5afd                	li	s5,-1
 84c:	a895                	j	8c0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 84e:	00000797          	auipc	a5,0x0
 852:	17278793          	addi	a5,a5,370 # 9c0 <base>
 856:	00000717          	auipc	a4,0x0
 85a:	16f73123          	sd	a5,354(a4) # 9b8 <freep>
 85e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 860:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 864:	b7e1                	j	82c <malloc+0x36>
      if(p->s.size == nunits)
 866:	02e48c63          	beq	s1,a4,89e <malloc+0xa8>
        p->s.size -= nunits;
 86a:	4137073b          	subw	a4,a4,s3
 86e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 870:	02071693          	slli	a3,a4,0x20
 874:	01c6d713          	srli	a4,a3,0x1c
 878:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 87a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 87e:	00000717          	auipc	a4,0x0
 882:	12a73d23          	sd	a0,314(a4) # 9b8 <freep>
      return (void*)(p + 1);
 886:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 88a:	70e2                	ld	ra,56(sp)
 88c:	7442                	ld	s0,48(sp)
 88e:	74a2                	ld	s1,40(sp)
 890:	7902                	ld	s2,32(sp)
 892:	69e2                	ld	s3,24(sp)
 894:	6a42                	ld	s4,16(sp)
 896:	6aa2                	ld	s5,8(sp)
 898:	6b02                	ld	s6,0(sp)
 89a:	6121                	addi	sp,sp,64
 89c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 89e:	6398                	ld	a4,0(a5)
 8a0:	e118                	sd	a4,0(a0)
 8a2:	bff1                	j	87e <malloc+0x88>
  hp->s.size = nu;
 8a4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8a8:	0541                	addi	a0,a0,16
 8aa:	00000097          	auipc	ra,0x0
 8ae:	eca080e7          	jalr	-310(ra) # 774 <free>
  return freep;
 8b2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8b6:	d971                	beqz	a0,88a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ba:	4798                	lw	a4,8(a5)
 8bc:	fa9775e3          	bgeu	a4,s1,866 <malloc+0x70>
    if(p == freep)
 8c0:	00093703          	ld	a4,0(s2)
 8c4:	853e                	mv	a0,a5
 8c6:	fef719e3          	bne	a4,a5,8b8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8ca:	8552                	mv	a0,s4
 8cc:	00000097          	auipc	ra,0x0
 8d0:	b80080e7          	jalr	-1152(ra) # 44c <sbrk>
  if(p == (char*)-1)
 8d4:	fd5518e3          	bne	a0,s5,8a4 <malloc+0xae>
        return 0;
 8d8:	4501                	li	a0,0
 8da:	bf45                	j	88a <malloc+0x94>
