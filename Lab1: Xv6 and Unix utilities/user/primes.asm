
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <redirect>:
#define R 0
#define W 1

void
redirect(int k, int p[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	84aa                	mv	s1,a0
   e:	892e                	mv	s2,a1
	close(k);
  10:	00000097          	auipc	ra,0x0
  14:	42e080e7          	jalr	1070(ra) # 43e <close>
	dup(p[k]);
  18:	048a                	slli	s1,s1,0x2
  1a:	94ca                	add	s1,s1,s2
  1c:	4088                	lw	a0,0(s1)
  1e:	00000097          	auipc	ra,0x0
  22:	470080e7          	jalr	1136(ra) # 48e <dup>
	close(p[R]);
  26:	00092503          	lw	a0,0(s2)
  2a:	00000097          	auipc	ra,0x0
  2e:	414080e7          	jalr	1044(ra) # 43e <close>
	close(p[W]);
  32:	00492503          	lw	a0,4(s2)
  36:	00000097          	auipc	ra,0x0
  3a:	408080e7          	jalr	1032(ra) # 43e <close>
}
  3e:	60e2                	ld	ra,24(sp)
  40:	6442                	ld	s0,16(sp)
  42:	64a2                	ld	s1,8(sp)
  44:	6902                	ld	s2,0(sp)
  46:	6105                	addi	sp,sp,32
  48:	8082                	ret

000000000000004a <filter>:

void 
filter(int p)
{
  4a:	7179                	addi	sp,sp,-48
  4c:	f406                	sd	ra,40(sp)
  4e:	f022                	sd	s0,32(sp)
  50:	ec26                	sd	s1,24(sp)
  52:	1800                	addi	s0,sp,48
  54:	84aa                	mv	s1,a0
	int n;
	while (read(R, &n, sizeof(n))) {
  56:	4611                	li	a2,4
  58:	fdc40593          	addi	a1,s0,-36
  5c:	4501                	li	a0,0
  5e:	00000097          	auipc	ra,0x0
  62:	3d0080e7          	jalr	976(ra) # 42e <read>
  66:	cd19                	beqz	a0,84 <filter+0x3a>
		if (n % p != 0) {
  68:	fdc42783          	lw	a5,-36(s0)
  6c:	0297e7bb          	remw	a5,a5,s1
  70:	d3fd                	beqz	a5,56 <filter+0xc>
			write(W, &n, sizeof(n));
  72:	4611                	li	a2,4
  74:	fdc40593          	addi	a1,s0,-36
  78:	4505                	li	a0,1
  7a:	00000097          	auipc	ra,0x0
  7e:	3bc080e7          	jalr	956(ra) # 436 <write>
  82:	bfd1                	j	56 <filter+0xc>
		}
	}
	close(W);
  84:	4505                	li	a0,1
  86:	00000097          	auipc	ra,0x0
  8a:	3b8080e7          	jalr	952(ra) # 43e <close>

	wait(0);
  8e:	4501                	li	a0,0
  90:	00000097          	auipc	ra,0x0
  94:	38e080e7          	jalr	910(ra) # 41e <wait>
	exit(0);
  98:	4501                	li	a0,0
  9a:	00000097          	auipc	ra,0x0
  9e:	37c080e7          	jalr	892(ra) # 416 <exit>

00000000000000a2 <waitForNumber>:
}

void
waitForNumber()
{
  a2:	1101                	addi	sp,sp,-32
  a4:	ec06                	sd	ra,24(sp)
  a6:	e822                	sd	s0,16(sp)
  a8:	1000                	addi	s0,sp,32
	int pd[2];
	int p;

	if (read(R, &p, sizeof(p))) {
  aa:	4611                	li	a2,4
  ac:	fe440593          	addi	a1,s0,-28
  b0:	4501                	li	a0,0
  b2:	00000097          	auipc	ra,0x0
  b6:	37c080e7          	jalr	892(ra) # 42e <read>
  ba:	cd29                	beqz	a0,114 <waitForNumber+0x72>
		printf("prime %d\n", p);
  bc:	fe442583          	lw	a1,-28(s0)
  c0:	00001517          	auipc	a0,0x1
  c4:	87050513          	addi	a0,a0,-1936 # 930 <malloc+0xe8>
  c8:	00000097          	auipc	ra,0x0
  cc:	6c8080e7          	jalr	1736(ra) # 790 <printf>
		pipe(pd);
  d0:	fe840513          	addi	a0,s0,-24
  d4:	00000097          	auipc	ra,0x0
  d8:	352080e7          	jalr	850(ra) # 426 <pipe>
		if (fork() == 0) {
  dc:	00000097          	auipc	ra,0x0
  e0:	332080e7          	jalr	818(ra) # 40e <fork>
  e4:	e919                	bnez	a0,fa <waitForNumber+0x58>
			redirect(R, pd);
  e6:	fe840593          	addi	a1,s0,-24
  ea:	00000097          	auipc	ra,0x0
  ee:	f16080e7          	jalr	-234(ra) # 0 <redirect>
			waitForNumber();
  f2:	00000097          	auipc	ra,0x0
  f6:	fb0080e7          	jalr	-80(ra) # a2 <waitForNumber>
		} else {
			redirect(W, pd);
  fa:	fe840593          	addi	a1,s0,-24
  fe:	4505                	li	a0,1
 100:	00000097          	auipc	ra,0x0
 104:	f00080e7          	jalr	-256(ra) # 0 <redirect>
			filter(p);
 108:	fe442503          	lw	a0,-28(s0)
 10c:	00000097          	auipc	ra,0x0
 110:	f3e080e7          	jalr	-194(ra) # 4a <filter>
		}
	}
	exit(0);
 114:	4501                	li	a0,0
 116:	00000097          	auipc	ra,0x0
 11a:	300080e7          	jalr	768(ra) # 416 <exit>

000000000000011e <main>:
}


int
main(int argc, char *argv[])
{
 11e:	7179                	addi	sp,sp,-48
 120:	f406                	sd	ra,40(sp)
 122:	f022                	sd	s0,32(sp)
 124:	ec26                	sd	s1,24(sp)
 126:	1800                	addi	s0,sp,48
	int pd[2];
	
	pipe(pd);
 128:	fd840513          	addi	a0,s0,-40
 12c:	00000097          	auipc	ra,0x0
 130:	2fa080e7          	jalr	762(ra) # 426 <pipe>

	if (fork() == 0) {
 134:	00000097          	auipc	ra,0x0
 138:	2da080e7          	jalr	730(ra) # 40e <fork>
 13c:	e919                	bnez	a0,152 <main+0x34>
		// child
		redirect(R, pd);
 13e:	fd840593          	addi	a1,s0,-40
 142:	00000097          	auipc	ra,0x0
 146:	ebe080e7          	jalr	-322(ra) # 0 <redirect>
		waitForNumber();
 14a:	00000097          	auipc	ra,0x0
 14e:	f58080e7          	jalr	-168(ra) # a2 <waitForNumber>
	} else {
		// parent
		redirect(W, pd);
 152:	fd840593          	addi	a1,s0,-40
 156:	4505                	li	a0,1
 158:	00000097          	auipc	ra,0x0
 15c:	ea8080e7          	jalr	-344(ra) # 0 <redirect>
		for (int i = 2; i < 36; i++) {
 160:	4789                	li	a5,2
 162:	fcf42a23          	sw	a5,-44(s0)
 166:	02300493          	li	s1,35
			write(W, &i, sizeof(i));
 16a:	4611                	li	a2,4
 16c:	fd440593          	addi	a1,s0,-44
 170:	4505                	li	a0,1
 172:	00000097          	auipc	ra,0x0
 176:	2c4080e7          	jalr	708(ra) # 436 <write>
		for (int i = 2; i < 36; i++) {
 17a:	fd442783          	lw	a5,-44(s0)
 17e:	2785                	addiw	a5,a5,1
 180:	0007871b          	sext.w	a4,a5
 184:	fcf42a23          	sw	a5,-44(s0)
 188:	fee4d1e3          	bge	s1,a4,16a <main+0x4c>
		}
		close(W);
 18c:	4505                	li	a0,1
 18e:	00000097          	auipc	ra,0x0
 192:	2b0080e7          	jalr	688(ra) # 43e <close>
		
		wait(0);
 196:	4501                	li	a0,0
 198:	00000097          	auipc	ra,0x0
 19c:	286080e7          	jalr	646(ra) # 41e <wait>
		exit(0);
 1a0:	4501                	li	a0,0
 1a2:	00000097          	auipc	ra,0x0
 1a6:	274080e7          	jalr	628(ra) # 416 <exit>

00000000000001aa <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1aa:	1141                	addi	sp,sp,-16
 1ac:	e422                	sd	s0,8(sp)
 1ae:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1b0:	87aa                	mv	a5,a0
 1b2:	0585                	addi	a1,a1,1
 1b4:	0785                	addi	a5,a5,1
 1b6:	fff5c703          	lbu	a4,-1(a1)
 1ba:	fee78fa3          	sb	a4,-1(a5)
 1be:	fb75                	bnez	a4,1b2 <strcpy+0x8>
    ;
  return os;
}
 1c0:	6422                	ld	s0,8(sp)
 1c2:	0141                	addi	sp,sp,16
 1c4:	8082                	ret

00000000000001c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c6:	1141                	addi	sp,sp,-16
 1c8:	e422                	sd	s0,8(sp)
 1ca:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	cb91                	beqz	a5,1e4 <strcmp+0x1e>
 1d2:	0005c703          	lbu	a4,0(a1)
 1d6:	00f71763          	bne	a4,a5,1e4 <strcmp+0x1e>
    p++, q++;
 1da:	0505                	addi	a0,a0,1
 1dc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1de:	00054783          	lbu	a5,0(a0)
 1e2:	fbe5                	bnez	a5,1d2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1e4:	0005c503          	lbu	a0,0(a1)
}
 1e8:	40a7853b          	subw	a0,a5,a0
 1ec:	6422                	ld	s0,8(sp)
 1ee:	0141                	addi	sp,sp,16
 1f0:	8082                	ret

00000000000001f2 <strlen>:

uint
strlen(const char *s)
{
 1f2:	1141                	addi	sp,sp,-16
 1f4:	e422                	sd	s0,8(sp)
 1f6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1f8:	00054783          	lbu	a5,0(a0)
 1fc:	cf91                	beqz	a5,218 <strlen+0x26>
 1fe:	0505                	addi	a0,a0,1
 200:	87aa                	mv	a5,a0
 202:	4685                	li	a3,1
 204:	9e89                	subw	a3,a3,a0
 206:	00f6853b          	addw	a0,a3,a5
 20a:	0785                	addi	a5,a5,1
 20c:	fff7c703          	lbu	a4,-1(a5)
 210:	fb7d                	bnez	a4,206 <strlen+0x14>
    ;
  return n;
}
 212:	6422                	ld	s0,8(sp)
 214:	0141                	addi	sp,sp,16
 216:	8082                	ret
  for(n = 0; s[n]; n++)
 218:	4501                	li	a0,0
 21a:	bfe5                	j	212 <strlen+0x20>

000000000000021c <memset>:

void*
memset(void *dst, int c, uint n)
{
 21c:	1141                	addi	sp,sp,-16
 21e:	e422                	sd	s0,8(sp)
 220:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 222:	ca19                	beqz	a2,238 <memset+0x1c>
 224:	87aa                	mv	a5,a0
 226:	1602                	slli	a2,a2,0x20
 228:	9201                	srli	a2,a2,0x20
 22a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 22e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 232:	0785                	addi	a5,a5,1
 234:	fee79de3          	bne	a5,a4,22e <memset+0x12>
  }
  return dst;
}
 238:	6422                	ld	s0,8(sp)
 23a:	0141                	addi	sp,sp,16
 23c:	8082                	ret

000000000000023e <strchr>:

char*
strchr(const char *s, char c)
{
 23e:	1141                	addi	sp,sp,-16
 240:	e422                	sd	s0,8(sp)
 242:	0800                	addi	s0,sp,16
  for(; *s; s++)
 244:	00054783          	lbu	a5,0(a0)
 248:	cb99                	beqz	a5,25e <strchr+0x20>
    if(*s == c)
 24a:	00f58763          	beq	a1,a5,258 <strchr+0x1a>
  for(; *s; s++)
 24e:	0505                	addi	a0,a0,1
 250:	00054783          	lbu	a5,0(a0)
 254:	fbfd                	bnez	a5,24a <strchr+0xc>
      return (char*)s;
  return 0;
 256:	4501                	li	a0,0
}
 258:	6422                	ld	s0,8(sp)
 25a:	0141                	addi	sp,sp,16
 25c:	8082                	ret
  return 0;
 25e:	4501                	li	a0,0
 260:	bfe5                	j	258 <strchr+0x1a>

0000000000000262 <gets>:

char*
gets(char *buf, int max)
{
 262:	711d                	addi	sp,sp,-96
 264:	ec86                	sd	ra,88(sp)
 266:	e8a2                	sd	s0,80(sp)
 268:	e4a6                	sd	s1,72(sp)
 26a:	e0ca                	sd	s2,64(sp)
 26c:	fc4e                	sd	s3,56(sp)
 26e:	f852                	sd	s4,48(sp)
 270:	f456                	sd	s5,40(sp)
 272:	f05a                	sd	s6,32(sp)
 274:	ec5e                	sd	s7,24(sp)
 276:	1080                	addi	s0,sp,96
 278:	8baa                	mv	s7,a0
 27a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 27c:	892a                	mv	s2,a0
 27e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 280:	4aa9                	li	s5,10
 282:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 284:	89a6                	mv	s3,s1
 286:	2485                	addiw	s1,s1,1
 288:	0344d863          	bge	s1,s4,2b8 <gets+0x56>
    cc = read(0, &c, 1);
 28c:	4605                	li	a2,1
 28e:	faf40593          	addi	a1,s0,-81
 292:	4501                	li	a0,0
 294:	00000097          	auipc	ra,0x0
 298:	19a080e7          	jalr	410(ra) # 42e <read>
    if(cc < 1)
 29c:	00a05e63          	blez	a0,2b8 <gets+0x56>
    buf[i++] = c;
 2a0:	faf44783          	lbu	a5,-81(s0)
 2a4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2a8:	01578763          	beq	a5,s5,2b6 <gets+0x54>
 2ac:	0905                	addi	s2,s2,1
 2ae:	fd679be3          	bne	a5,s6,284 <gets+0x22>
  for(i=0; i+1 < max; ){
 2b2:	89a6                	mv	s3,s1
 2b4:	a011                	j	2b8 <gets+0x56>
 2b6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2b8:	99de                	add	s3,s3,s7
 2ba:	00098023          	sb	zero,0(s3)
  return buf;
}
 2be:	855e                	mv	a0,s7
 2c0:	60e6                	ld	ra,88(sp)
 2c2:	6446                	ld	s0,80(sp)
 2c4:	64a6                	ld	s1,72(sp)
 2c6:	6906                	ld	s2,64(sp)
 2c8:	79e2                	ld	s3,56(sp)
 2ca:	7a42                	ld	s4,48(sp)
 2cc:	7aa2                	ld	s5,40(sp)
 2ce:	7b02                	ld	s6,32(sp)
 2d0:	6be2                	ld	s7,24(sp)
 2d2:	6125                	addi	sp,sp,96
 2d4:	8082                	ret

00000000000002d6 <stat>:

int
stat(const char *n, struct stat *st)
{
 2d6:	1101                	addi	sp,sp,-32
 2d8:	ec06                	sd	ra,24(sp)
 2da:	e822                	sd	s0,16(sp)
 2dc:	e426                	sd	s1,8(sp)
 2de:	e04a                	sd	s2,0(sp)
 2e0:	1000                	addi	s0,sp,32
 2e2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e4:	4581                	li	a1,0
 2e6:	00000097          	auipc	ra,0x0
 2ea:	170080e7          	jalr	368(ra) # 456 <open>
  if(fd < 0)
 2ee:	02054563          	bltz	a0,318 <stat+0x42>
 2f2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2f4:	85ca                	mv	a1,s2
 2f6:	00000097          	auipc	ra,0x0
 2fa:	178080e7          	jalr	376(ra) # 46e <fstat>
 2fe:	892a                	mv	s2,a0
  close(fd);
 300:	8526                	mv	a0,s1
 302:	00000097          	auipc	ra,0x0
 306:	13c080e7          	jalr	316(ra) # 43e <close>
  return r;
}
 30a:	854a                	mv	a0,s2
 30c:	60e2                	ld	ra,24(sp)
 30e:	6442                	ld	s0,16(sp)
 310:	64a2                	ld	s1,8(sp)
 312:	6902                	ld	s2,0(sp)
 314:	6105                	addi	sp,sp,32
 316:	8082                	ret
    return -1;
 318:	597d                	li	s2,-1
 31a:	bfc5                	j	30a <stat+0x34>

000000000000031c <atoi>:

int
atoi(const char *s)
{
 31c:	1141                	addi	sp,sp,-16
 31e:	e422                	sd	s0,8(sp)
 320:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 322:	00054683          	lbu	a3,0(a0)
 326:	fd06879b          	addiw	a5,a3,-48
 32a:	0ff7f793          	zext.b	a5,a5
 32e:	4625                	li	a2,9
 330:	02f66863          	bltu	a2,a5,360 <atoi+0x44>
 334:	872a                	mv	a4,a0
  n = 0;
 336:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 338:	0705                	addi	a4,a4,1
 33a:	0025179b          	slliw	a5,a0,0x2
 33e:	9fa9                	addw	a5,a5,a0
 340:	0017979b          	slliw	a5,a5,0x1
 344:	9fb5                	addw	a5,a5,a3
 346:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 34a:	00074683          	lbu	a3,0(a4)
 34e:	fd06879b          	addiw	a5,a3,-48
 352:	0ff7f793          	zext.b	a5,a5
 356:	fef671e3          	bgeu	a2,a5,338 <atoi+0x1c>
  return n;
}
 35a:	6422                	ld	s0,8(sp)
 35c:	0141                	addi	sp,sp,16
 35e:	8082                	ret
  n = 0;
 360:	4501                	li	a0,0
 362:	bfe5                	j	35a <atoi+0x3e>

0000000000000364 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 364:	1141                	addi	sp,sp,-16
 366:	e422                	sd	s0,8(sp)
 368:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 36a:	02b57463          	bgeu	a0,a1,392 <memmove+0x2e>
    while(n-- > 0)
 36e:	00c05f63          	blez	a2,38c <memmove+0x28>
 372:	1602                	slli	a2,a2,0x20
 374:	9201                	srli	a2,a2,0x20
 376:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 37a:	872a                	mv	a4,a0
      *dst++ = *src++;
 37c:	0585                	addi	a1,a1,1
 37e:	0705                	addi	a4,a4,1
 380:	fff5c683          	lbu	a3,-1(a1)
 384:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 388:	fee79ae3          	bne	a5,a4,37c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 38c:	6422                	ld	s0,8(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret
    dst += n;
 392:	00c50733          	add	a4,a0,a2
    src += n;
 396:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 398:	fec05ae3          	blez	a2,38c <memmove+0x28>
 39c:	fff6079b          	addiw	a5,a2,-1
 3a0:	1782                	slli	a5,a5,0x20
 3a2:	9381                	srli	a5,a5,0x20
 3a4:	fff7c793          	not	a5,a5
 3a8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3aa:	15fd                	addi	a1,a1,-1
 3ac:	177d                	addi	a4,a4,-1
 3ae:	0005c683          	lbu	a3,0(a1)
 3b2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3b6:	fee79ae3          	bne	a5,a4,3aa <memmove+0x46>
 3ba:	bfc9                	j	38c <memmove+0x28>

00000000000003bc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3bc:	1141                	addi	sp,sp,-16
 3be:	e422                	sd	s0,8(sp)
 3c0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3c2:	ca05                	beqz	a2,3f2 <memcmp+0x36>
 3c4:	fff6069b          	addiw	a3,a2,-1
 3c8:	1682                	slli	a3,a3,0x20
 3ca:	9281                	srli	a3,a3,0x20
 3cc:	0685                	addi	a3,a3,1
 3ce:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3d0:	00054783          	lbu	a5,0(a0)
 3d4:	0005c703          	lbu	a4,0(a1)
 3d8:	00e79863          	bne	a5,a4,3e8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3dc:	0505                	addi	a0,a0,1
    p2++;
 3de:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3e0:	fed518e3          	bne	a0,a3,3d0 <memcmp+0x14>
  }
  return 0;
 3e4:	4501                	li	a0,0
 3e6:	a019                	j	3ec <memcmp+0x30>
      return *p1 - *p2;
 3e8:	40e7853b          	subw	a0,a5,a4
}
 3ec:	6422                	ld	s0,8(sp)
 3ee:	0141                	addi	sp,sp,16
 3f0:	8082                	ret
  return 0;
 3f2:	4501                	li	a0,0
 3f4:	bfe5                	j	3ec <memcmp+0x30>

00000000000003f6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3f6:	1141                	addi	sp,sp,-16
 3f8:	e406                	sd	ra,8(sp)
 3fa:	e022                	sd	s0,0(sp)
 3fc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3fe:	00000097          	auipc	ra,0x0
 402:	f66080e7          	jalr	-154(ra) # 364 <memmove>
}
 406:	60a2                	ld	ra,8(sp)
 408:	6402                	ld	s0,0(sp)
 40a:	0141                	addi	sp,sp,16
 40c:	8082                	ret

000000000000040e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 40e:	4885                	li	a7,1
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <exit>:
.global exit
exit:
 li a7, SYS_exit
 416:	4889                	li	a7,2
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <wait>:
.global wait
wait:
 li a7, SYS_wait
 41e:	488d                	li	a7,3
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 426:	4891                	li	a7,4
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <read>:
.global read
read:
 li a7, SYS_read
 42e:	4895                	li	a7,5
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <write>:
.global write
write:
 li a7, SYS_write
 436:	48c1                	li	a7,16
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <close>:
.global close
close:
 li a7, SYS_close
 43e:	48d5                	li	a7,21
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <kill>:
.global kill
kill:
 li a7, SYS_kill
 446:	4899                	li	a7,6
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <exec>:
.global exec
exec:
 li a7, SYS_exec
 44e:	489d                	li	a7,7
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <open>:
.global open
open:
 li a7, SYS_open
 456:	48bd                	li	a7,15
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 45e:	48c5                	li	a7,17
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 466:	48c9                	li	a7,18
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 46e:	48a1                	li	a7,8
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <link>:
.global link
link:
 li a7, SYS_link
 476:	48cd                	li	a7,19
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 47e:	48d1                	li	a7,20
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 486:	48a5                	li	a7,9
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <dup>:
.global dup
dup:
 li a7, SYS_dup
 48e:	48a9                	li	a7,10
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 496:	48ad                	li	a7,11
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 49e:	48b1                	li	a7,12
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4a6:	48b5                	li	a7,13
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4ae:	48b9                	li	a7,14
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4b6:	1101                	addi	sp,sp,-32
 4b8:	ec06                	sd	ra,24(sp)
 4ba:	e822                	sd	s0,16(sp)
 4bc:	1000                	addi	s0,sp,32
 4be:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4c2:	4605                	li	a2,1
 4c4:	fef40593          	addi	a1,s0,-17
 4c8:	00000097          	auipc	ra,0x0
 4cc:	f6e080e7          	jalr	-146(ra) # 436 <write>
}
 4d0:	60e2                	ld	ra,24(sp)
 4d2:	6442                	ld	s0,16(sp)
 4d4:	6105                	addi	sp,sp,32
 4d6:	8082                	ret

00000000000004d8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4d8:	7139                	addi	sp,sp,-64
 4da:	fc06                	sd	ra,56(sp)
 4dc:	f822                	sd	s0,48(sp)
 4de:	f426                	sd	s1,40(sp)
 4e0:	f04a                	sd	s2,32(sp)
 4e2:	ec4e                	sd	s3,24(sp)
 4e4:	0080                	addi	s0,sp,64
 4e6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4e8:	c299                	beqz	a3,4ee <printint+0x16>
 4ea:	0805c963          	bltz	a1,57c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4ee:	2581                	sext.w	a1,a1
  neg = 0;
 4f0:	4881                	li	a7,0
 4f2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4f6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4f8:	2601                	sext.w	a2,a2
 4fa:	00000517          	auipc	a0,0x0
 4fe:	4a650513          	addi	a0,a0,1190 # 9a0 <digits>
 502:	883a                	mv	a6,a4
 504:	2705                	addiw	a4,a4,1
 506:	02c5f7bb          	remuw	a5,a1,a2
 50a:	1782                	slli	a5,a5,0x20
 50c:	9381                	srli	a5,a5,0x20
 50e:	97aa                	add	a5,a5,a0
 510:	0007c783          	lbu	a5,0(a5)
 514:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 518:	0005879b          	sext.w	a5,a1
 51c:	02c5d5bb          	divuw	a1,a1,a2
 520:	0685                	addi	a3,a3,1
 522:	fec7f0e3          	bgeu	a5,a2,502 <printint+0x2a>
  if(neg)
 526:	00088c63          	beqz	a7,53e <printint+0x66>
    buf[i++] = '-';
 52a:	fd070793          	addi	a5,a4,-48
 52e:	00878733          	add	a4,a5,s0
 532:	02d00793          	li	a5,45
 536:	fef70823          	sb	a5,-16(a4)
 53a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 53e:	02e05863          	blez	a4,56e <printint+0x96>
 542:	fc040793          	addi	a5,s0,-64
 546:	00e78933          	add	s2,a5,a4
 54a:	fff78993          	addi	s3,a5,-1
 54e:	99ba                	add	s3,s3,a4
 550:	377d                	addiw	a4,a4,-1
 552:	1702                	slli	a4,a4,0x20
 554:	9301                	srli	a4,a4,0x20
 556:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 55a:	fff94583          	lbu	a1,-1(s2)
 55e:	8526                	mv	a0,s1
 560:	00000097          	auipc	ra,0x0
 564:	f56080e7          	jalr	-170(ra) # 4b6 <putc>
  while(--i >= 0)
 568:	197d                	addi	s2,s2,-1
 56a:	ff3918e3          	bne	s2,s3,55a <printint+0x82>
}
 56e:	70e2                	ld	ra,56(sp)
 570:	7442                	ld	s0,48(sp)
 572:	74a2                	ld	s1,40(sp)
 574:	7902                	ld	s2,32(sp)
 576:	69e2                	ld	s3,24(sp)
 578:	6121                	addi	sp,sp,64
 57a:	8082                	ret
    x = -xx;
 57c:	40b005bb          	negw	a1,a1
    neg = 1;
 580:	4885                	li	a7,1
    x = -xx;
 582:	bf85                	j	4f2 <printint+0x1a>

0000000000000584 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 584:	7119                	addi	sp,sp,-128
 586:	fc86                	sd	ra,120(sp)
 588:	f8a2                	sd	s0,112(sp)
 58a:	f4a6                	sd	s1,104(sp)
 58c:	f0ca                	sd	s2,96(sp)
 58e:	ecce                	sd	s3,88(sp)
 590:	e8d2                	sd	s4,80(sp)
 592:	e4d6                	sd	s5,72(sp)
 594:	e0da                	sd	s6,64(sp)
 596:	fc5e                	sd	s7,56(sp)
 598:	f862                	sd	s8,48(sp)
 59a:	f466                	sd	s9,40(sp)
 59c:	f06a                	sd	s10,32(sp)
 59e:	ec6e                	sd	s11,24(sp)
 5a0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5a2:	0005c903          	lbu	s2,0(a1)
 5a6:	18090f63          	beqz	s2,744 <vprintf+0x1c0>
 5aa:	8aaa                	mv	s5,a0
 5ac:	8b32                	mv	s6,a2
 5ae:	00158493          	addi	s1,a1,1
  state = 0;
 5b2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5b4:	02500a13          	li	s4,37
 5b8:	4c55                	li	s8,21
 5ba:	00000c97          	auipc	s9,0x0
 5be:	38ec8c93          	addi	s9,s9,910 # 948 <malloc+0x100>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5c2:	02800d93          	li	s11,40
  putc(fd, 'x');
 5c6:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5c8:	00000b97          	auipc	s7,0x0
 5cc:	3d8b8b93          	addi	s7,s7,984 # 9a0 <digits>
 5d0:	a839                	j	5ee <vprintf+0x6a>
        putc(fd, c);
 5d2:	85ca                	mv	a1,s2
 5d4:	8556                	mv	a0,s5
 5d6:	00000097          	auipc	ra,0x0
 5da:	ee0080e7          	jalr	-288(ra) # 4b6 <putc>
 5de:	a019                	j	5e4 <vprintf+0x60>
    } else if(state == '%'){
 5e0:	01498d63          	beq	s3,s4,5fa <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 5e4:	0485                	addi	s1,s1,1
 5e6:	fff4c903          	lbu	s2,-1(s1)
 5ea:	14090d63          	beqz	s2,744 <vprintf+0x1c0>
    if(state == 0){
 5ee:	fe0999e3          	bnez	s3,5e0 <vprintf+0x5c>
      if(c == '%'){
 5f2:	ff4910e3          	bne	s2,s4,5d2 <vprintf+0x4e>
        state = '%';
 5f6:	89d2                	mv	s3,s4
 5f8:	b7f5                	j	5e4 <vprintf+0x60>
      if(c == 'd'){
 5fa:	11490c63          	beq	s2,s4,712 <vprintf+0x18e>
 5fe:	f9d9079b          	addiw	a5,s2,-99
 602:	0ff7f793          	zext.b	a5,a5
 606:	10fc6e63          	bltu	s8,a5,722 <vprintf+0x19e>
 60a:	f9d9079b          	addiw	a5,s2,-99
 60e:	0ff7f713          	zext.b	a4,a5
 612:	10ec6863          	bltu	s8,a4,722 <vprintf+0x19e>
 616:	00271793          	slli	a5,a4,0x2
 61a:	97e6                	add	a5,a5,s9
 61c:	439c                	lw	a5,0(a5)
 61e:	97e6                	add	a5,a5,s9
 620:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 622:	008b0913          	addi	s2,s6,8
 626:	4685                	li	a3,1
 628:	4629                	li	a2,10
 62a:	000b2583          	lw	a1,0(s6)
 62e:	8556                	mv	a0,s5
 630:	00000097          	auipc	ra,0x0
 634:	ea8080e7          	jalr	-344(ra) # 4d8 <printint>
 638:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 63a:	4981                	li	s3,0
 63c:	b765                	j	5e4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 63e:	008b0913          	addi	s2,s6,8
 642:	4681                	li	a3,0
 644:	4629                	li	a2,10
 646:	000b2583          	lw	a1,0(s6)
 64a:	8556                	mv	a0,s5
 64c:	00000097          	auipc	ra,0x0
 650:	e8c080e7          	jalr	-372(ra) # 4d8 <printint>
 654:	8b4a                	mv	s6,s2
      state = 0;
 656:	4981                	li	s3,0
 658:	b771                	j	5e4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 65a:	008b0913          	addi	s2,s6,8
 65e:	4681                	li	a3,0
 660:	866a                	mv	a2,s10
 662:	000b2583          	lw	a1,0(s6)
 666:	8556                	mv	a0,s5
 668:	00000097          	auipc	ra,0x0
 66c:	e70080e7          	jalr	-400(ra) # 4d8 <printint>
 670:	8b4a                	mv	s6,s2
      state = 0;
 672:	4981                	li	s3,0
 674:	bf85                	j	5e4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 676:	008b0793          	addi	a5,s6,8
 67a:	f8f43423          	sd	a5,-120(s0)
 67e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 682:	03000593          	li	a1,48
 686:	8556                	mv	a0,s5
 688:	00000097          	auipc	ra,0x0
 68c:	e2e080e7          	jalr	-466(ra) # 4b6 <putc>
  putc(fd, 'x');
 690:	07800593          	li	a1,120
 694:	8556                	mv	a0,s5
 696:	00000097          	auipc	ra,0x0
 69a:	e20080e7          	jalr	-480(ra) # 4b6 <putc>
 69e:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6a0:	03c9d793          	srli	a5,s3,0x3c
 6a4:	97de                	add	a5,a5,s7
 6a6:	0007c583          	lbu	a1,0(a5)
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	e0a080e7          	jalr	-502(ra) # 4b6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6b4:	0992                	slli	s3,s3,0x4
 6b6:	397d                	addiw	s2,s2,-1
 6b8:	fe0914e3          	bnez	s2,6a0 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 6bc:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6c0:	4981                	li	s3,0
 6c2:	b70d                	j	5e4 <vprintf+0x60>
        s = va_arg(ap, char*);
 6c4:	008b0913          	addi	s2,s6,8
 6c8:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 6cc:	02098163          	beqz	s3,6ee <vprintf+0x16a>
        while(*s != 0){
 6d0:	0009c583          	lbu	a1,0(s3)
 6d4:	c5ad                	beqz	a1,73e <vprintf+0x1ba>
          putc(fd, *s);
 6d6:	8556                	mv	a0,s5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	dde080e7          	jalr	-546(ra) # 4b6 <putc>
          s++;
 6e0:	0985                	addi	s3,s3,1
        while(*s != 0){
 6e2:	0009c583          	lbu	a1,0(s3)
 6e6:	f9e5                	bnez	a1,6d6 <vprintf+0x152>
        s = va_arg(ap, char*);
 6e8:	8b4a                	mv	s6,s2
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	bde5                	j	5e4 <vprintf+0x60>
          s = "(null)";
 6ee:	00000997          	auipc	s3,0x0
 6f2:	25298993          	addi	s3,s3,594 # 940 <malloc+0xf8>
        while(*s != 0){
 6f6:	85ee                	mv	a1,s11
 6f8:	bff9                	j	6d6 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 6fa:	008b0913          	addi	s2,s6,8
 6fe:	000b4583          	lbu	a1,0(s6)
 702:	8556                	mv	a0,s5
 704:	00000097          	auipc	ra,0x0
 708:	db2080e7          	jalr	-590(ra) # 4b6 <putc>
 70c:	8b4a                	mv	s6,s2
      state = 0;
 70e:	4981                	li	s3,0
 710:	bdd1                	j	5e4 <vprintf+0x60>
        putc(fd, c);
 712:	85d2                	mv	a1,s4
 714:	8556                	mv	a0,s5
 716:	00000097          	auipc	ra,0x0
 71a:	da0080e7          	jalr	-608(ra) # 4b6 <putc>
      state = 0;
 71e:	4981                	li	s3,0
 720:	b5d1                	j	5e4 <vprintf+0x60>
        putc(fd, '%');
 722:	85d2                	mv	a1,s4
 724:	8556                	mv	a0,s5
 726:	00000097          	auipc	ra,0x0
 72a:	d90080e7          	jalr	-624(ra) # 4b6 <putc>
        putc(fd, c);
 72e:	85ca                	mv	a1,s2
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	d84080e7          	jalr	-636(ra) # 4b6 <putc>
      state = 0;
 73a:	4981                	li	s3,0
 73c:	b565                	j	5e4 <vprintf+0x60>
        s = va_arg(ap, char*);
 73e:	8b4a                	mv	s6,s2
      state = 0;
 740:	4981                	li	s3,0
 742:	b54d                	j	5e4 <vprintf+0x60>
    }
  }
}
 744:	70e6                	ld	ra,120(sp)
 746:	7446                	ld	s0,112(sp)
 748:	74a6                	ld	s1,104(sp)
 74a:	7906                	ld	s2,96(sp)
 74c:	69e6                	ld	s3,88(sp)
 74e:	6a46                	ld	s4,80(sp)
 750:	6aa6                	ld	s5,72(sp)
 752:	6b06                	ld	s6,64(sp)
 754:	7be2                	ld	s7,56(sp)
 756:	7c42                	ld	s8,48(sp)
 758:	7ca2                	ld	s9,40(sp)
 75a:	7d02                	ld	s10,32(sp)
 75c:	6de2                	ld	s11,24(sp)
 75e:	6109                	addi	sp,sp,128
 760:	8082                	ret

0000000000000762 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 762:	715d                	addi	sp,sp,-80
 764:	ec06                	sd	ra,24(sp)
 766:	e822                	sd	s0,16(sp)
 768:	1000                	addi	s0,sp,32
 76a:	e010                	sd	a2,0(s0)
 76c:	e414                	sd	a3,8(s0)
 76e:	e818                	sd	a4,16(s0)
 770:	ec1c                	sd	a5,24(s0)
 772:	03043023          	sd	a6,32(s0)
 776:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 77a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 77e:	8622                	mv	a2,s0
 780:	00000097          	auipc	ra,0x0
 784:	e04080e7          	jalr	-508(ra) # 584 <vprintf>
}
 788:	60e2                	ld	ra,24(sp)
 78a:	6442                	ld	s0,16(sp)
 78c:	6161                	addi	sp,sp,80
 78e:	8082                	ret

0000000000000790 <printf>:

void
printf(const char *fmt, ...)
{
 790:	711d                	addi	sp,sp,-96
 792:	ec06                	sd	ra,24(sp)
 794:	e822                	sd	s0,16(sp)
 796:	1000                	addi	s0,sp,32
 798:	e40c                	sd	a1,8(s0)
 79a:	e810                	sd	a2,16(s0)
 79c:	ec14                	sd	a3,24(s0)
 79e:	f018                	sd	a4,32(s0)
 7a0:	f41c                	sd	a5,40(s0)
 7a2:	03043823          	sd	a6,48(s0)
 7a6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7aa:	00840613          	addi	a2,s0,8
 7ae:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7b2:	85aa                	mv	a1,a0
 7b4:	4505                	li	a0,1
 7b6:	00000097          	auipc	ra,0x0
 7ba:	dce080e7          	jalr	-562(ra) # 584 <vprintf>
}
 7be:	60e2                	ld	ra,24(sp)
 7c0:	6442                	ld	s0,16(sp)
 7c2:	6125                	addi	sp,sp,96
 7c4:	8082                	ret

00000000000007c6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c6:	1141                	addi	sp,sp,-16
 7c8:	e422                	sd	s0,8(sp)
 7ca:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7cc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d0:	00000797          	auipc	a5,0x0
 7d4:	1e87b783          	ld	a5,488(a5) # 9b8 <freep>
 7d8:	a02d                	j	802 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7da:	4618                	lw	a4,8(a2)
 7dc:	9f2d                	addw	a4,a4,a1
 7de:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e2:	6398                	ld	a4,0(a5)
 7e4:	6310                	ld	a2,0(a4)
 7e6:	a83d                	j	824 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7e8:	ff852703          	lw	a4,-8(a0)
 7ec:	9f31                	addw	a4,a4,a2
 7ee:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7f0:	ff053683          	ld	a3,-16(a0)
 7f4:	a091                	j	838 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f6:	6398                	ld	a4,0(a5)
 7f8:	00e7e463          	bltu	a5,a4,800 <free+0x3a>
 7fc:	00e6ea63          	bltu	a3,a4,810 <free+0x4a>
{
 800:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 802:	fed7fae3          	bgeu	a5,a3,7f6 <free+0x30>
 806:	6398                	ld	a4,0(a5)
 808:	00e6e463          	bltu	a3,a4,810 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80c:	fee7eae3          	bltu	a5,a4,800 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 810:	ff852583          	lw	a1,-8(a0)
 814:	6390                	ld	a2,0(a5)
 816:	02059813          	slli	a6,a1,0x20
 81a:	01c85713          	srli	a4,a6,0x1c
 81e:	9736                	add	a4,a4,a3
 820:	fae60de3          	beq	a2,a4,7da <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 824:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 828:	4790                	lw	a2,8(a5)
 82a:	02061593          	slli	a1,a2,0x20
 82e:	01c5d713          	srli	a4,a1,0x1c
 832:	973e                	add	a4,a4,a5
 834:	fae68ae3          	beq	a3,a4,7e8 <free+0x22>
    p->s.ptr = bp->s.ptr;
 838:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 83a:	00000717          	auipc	a4,0x0
 83e:	16f73f23          	sd	a5,382(a4) # 9b8 <freep>
}
 842:	6422                	ld	s0,8(sp)
 844:	0141                	addi	sp,sp,16
 846:	8082                	ret

0000000000000848 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 848:	7139                	addi	sp,sp,-64
 84a:	fc06                	sd	ra,56(sp)
 84c:	f822                	sd	s0,48(sp)
 84e:	f426                	sd	s1,40(sp)
 850:	f04a                	sd	s2,32(sp)
 852:	ec4e                	sd	s3,24(sp)
 854:	e852                	sd	s4,16(sp)
 856:	e456                	sd	s5,8(sp)
 858:	e05a                	sd	s6,0(sp)
 85a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 85c:	02051493          	slli	s1,a0,0x20
 860:	9081                	srli	s1,s1,0x20
 862:	04bd                	addi	s1,s1,15
 864:	8091                	srli	s1,s1,0x4
 866:	0014899b          	addiw	s3,s1,1
 86a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 86c:	00000517          	auipc	a0,0x0
 870:	14c53503          	ld	a0,332(a0) # 9b8 <freep>
 874:	c515                	beqz	a0,8a0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 876:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 878:	4798                	lw	a4,8(a5)
 87a:	02977f63          	bgeu	a4,s1,8b8 <malloc+0x70>
 87e:	8a4e                	mv	s4,s3
 880:	0009871b          	sext.w	a4,s3
 884:	6685                	lui	a3,0x1
 886:	00d77363          	bgeu	a4,a3,88c <malloc+0x44>
 88a:	6a05                	lui	s4,0x1
 88c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 890:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 894:	00000917          	auipc	s2,0x0
 898:	12490913          	addi	s2,s2,292 # 9b8 <freep>
  if(p == (char*)-1)
 89c:	5afd                	li	s5,-1
 89e:	a895                	j	912 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 8a0:	00000797          	auipc	a5,0x0
 8a4:	12078793          	addi	a5,a5,288 # 9c0 <base>
 8a8:	00000717          	auipc	a4,0x0
 8ac:	10f73823          	sd	a5,272(a4) # 9b8 <freep>
 8b0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8b2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8b6:	b7e1                	j	87e <malloc+0x36>
      if(p->s.size == nunits)
 8b8:	02e48c63          	beq	s1,a4,8f0 <malloc+0xa8>
        p->s.size -= nunits;
 8bc:	4137073b          	subw	a4,a4,s3
 8c0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8c2:	02071693          	slli	a3,a4,0x20
 8c6:	01c6d713          	srli	a4,a3,0x1c
 8ca:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8cc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8d0:	00000717          	auipc	a4,0x0
 8d4:	0ea73423          	sd	a0,232(a4) # 9b8 <freep>
      return (void*)(p + 1);
 8d8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8dc:	70e2                	ld	ra,56(sp)
 8de:	7442                	ld	s0,48(sp)
 8e0:	74a2                	ld	s1,40(sp)
 8e2:	7902                	ld	s2,32(sp)
 8e4:	69e2                	ld	s3,24(sp)
 8e6:	6a42                	ld	s4,16(sp)
 8e8:	6aa2                	ld	s5,8(sp)
 8ea:	6b02                	ld	s6,0(sp)
 8ec:	6121                	addi	sp,sp,64
 8ee:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8f0:	6398                	ld	a4,0(a5)
 8f2:	e118                	sd	a4,0(a0)
 8f4:	bff1                	j	8d0 <malloc+0x88>
  hp->s.size = nu;
 8f6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8fa:	0541                	addi	a0,a0,16
 8fc:	00000097          	auipc	ra,0x0
 900:	eca080e7          	jalr	-310(ra) # 7c6 <free>
  return freep;
 904:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 908:	d971                	beqz	a0,8dc <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 90a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 90c:	4798                	lw	a4,8(a5)
 90e:	fa9775e3          	bgeu	a4,s1,8b8 <malloc+0x70>
    if(p == freep)
 912:	00093703          	ld	a4,0(s2)
 916:	853e                	mv	a0,a5
 918:	fef719e3          	bne	a4,a5,90a <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 91c:	8552                	mv	a0,s4
 91e:	00000097          	auipc	ra,0x0
 922:	b80080e7          	jalr	-1152(ra) # 49e <sbrk>
  if(p == (char*)-1)
 926:	fd5518e3          	bne	a0,s5,8f6 <malloc+0xae>
        return 0;
 92a:	4501                	li	a0,0
 92c:	bf45                	j	8dc <malloc+0x94>
