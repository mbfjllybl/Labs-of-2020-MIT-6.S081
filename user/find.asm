
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

void find(char *dir, char *file)
{
   0:	d9010113          	addi	sp,sp,-624
   4:	26113423          	sd	ra,616(sp)
   8:	26813023          	sd	s0,608(sp)
   c:	24913c23          	sd	s1,600(sp)
  10:	25213823          	sd	s2,592(sp)
  14:	25313423          	sd	s3,584(sp)
  18:	25413023          	sd	s4,576(sp)
  1c:	23513c23          	sd	s5,568(sp)
  20:	23613823          	sd	s6,560(sp)
  24:	1c80                	addi	s0,sp,624
  26:	892a                	mv	s2,a0
  28:	89ae                	mv	s3,a1
	char buf[512], *p;
	int fd;
	struct dirent de;
	struct stat st;

	if ((fd = open(dir, 0)) < 0) {
  2a:	4581                	li	a1,0
  2c:	00000097          	auipc	ra,0x0
  30:	4cc080e7          	jalr	1228(ra) # 4f8 <open>
  34:	06054263          	bltz	a0,98 <find+0x98>
  38:	84aa                	mv	s1,a0
		fprintf(2, "find: cannot open %s\n", dir);
		return;
	}

	if (fstat(fd, &st) < 0) {
  3a:	d9840593          	addi	a1,s0,-616
  3e:	00000097          	auipc	ra,0x0
  42:	4d2080e7          	jalr	1234(ra) # 510 <fstat>
  46:	06054463          	bltz	a0,ae <find+0xae>
		fprintf(2, "find: cannot stat %s\n", dir);
		close(fd);
		return;
	}

	if (st.type != T_DIR) {
  4a:	da041703          	lh	a4,-608(s0)
  4e:	4785                	li	a5,1
  50:	06f70f63          	beq	a4,a5,ce <find+0xce>
		fprintf(2, "find: %s is not a directory\n",dir);
  54:	864a                	mv	a2,s2
  56:	00001597          	auipc	a1,0x1
  5a:	9aa58593          	addi	a1,a1,-1622 # a00 <malloc+0x116>
  5e:	4509                	li	a0,2
  60:	00000097          	auipc	ra,0x0
  64:	7a4080e7          	jalr	1956(ra) # 804 <fprintf>
		close(fd);
  68:	8526                	mv	a0,s1
  6a:	00000097          	auipc	ra,0x0
  6e:	476080e7          	jalr	1142(ra) # 4e0 <close>
			find(buf, file);
		} else if (st.type == T_FILE && !strcmp(de.name, file)) {
			printf("%s\n", buf);
		}
	}
}
  72:	26813083          	ld	ra,616(sp)
  76:	26013403          	ld	s0,608(sp)
  7a:	25813483          	ld	s1,600(sp)
  7e:	25013903          	ld	s2,592(sp)
  82:	24813983          	ld	s3,584(sp)
  86:	24013a03          	ld	s4,576(sp)
  8a:	23813a83          	ld	s5,568(sp)
  8e:	23013b03          	ld	s6,560(sp)
  92:	27010113          	addi	sp,sp,624
  96:	8082                	ret
		fprintf(2, "find: cannot open %s\n", dir);
  98:	864a                	mv	a2,s2
  9a:	00001597          	auipc	a1,0x1
  9e:	93658593          	addi	a1,a1,-1738 # 9d0 <malloc+0xe6>
  a2:	4509                	li	a0,2
  a4:	00000097          	auipc	ra,0x0
  a8:	760080e7          	jalr	1888(ra) # 804 <fprintf>
		return;
  ac:	b7d9                	j	72 <find+0x72>
		fprintf(2, "find: cannot stat %s\n", dir);
  ae:	864a                	mv	a2,s2
  b0:	00001597          	auipc	a1,0x1
  b4:	93858593          	addi	a1,a1,-1736 # 9e8 <malloc+0xfe>
  b8:	4509                	li	a0,2
  ba:	00000097          	auipc	ra,0x0
  be:	74a080e7          	jalr	1866(ra) # 804 <fprintf>
		close(fd);
  c2:	8526                	mv	a0,s1
  c4:	00000097          	auipc	ra,0x0
  c8:	41c080e7          	jalr	1052(ra) # 4e0 <close>
		return;
  cc:	b75d                	j	72 <find+0x72>
	if (strlen(dir) + 1 + DIRSIZ + 1 > sizeof buf) {
  ce:	854a                	mv	a0,s2
  d0:	00000097          	auipc	ra,0x0
  d4:	1c4080e7          	jalr	452(ra) # 294 <strlen>
  d8:	2541                	addiw	a0,a0,16
  da:	20000793          	li	a5,512
  de:	0ea7e363          	bltu	a5,a0,1c4 <find+0x1c4>
	strcpy(buf, dir);
  e2:	85ca                	mv	a1,s2
  e4:	dc040513          	addi	a0,s0,-576
  e8:	00000097          	auipc	ra,0x0
  ec:	164080e7          	jalr	356(ra) # 24c <strcpy>
	p = buf + strlen(buf);
  f0:	dc040513          	addi	a0,s0,-576
  f4:	00000097          	auipc	ra,0x0
  f8:	1a0080e7          	jalr	416(ra) # 294 <strlen>
  fc:	1502                	slli	a0,a0,0x20
  fe:	9101                	srli	a0,a0,0x20
 100:	dc040793          	addi	a5,s0,-576
 104:	00a78933          	add	s2,a5,a0
	*p++ = '/';
 108:	00190b13          	addi	s6,s2,1
 10c:	02f00793          	li	a5,47
 110:	00f90023          	sb	a5,0(s2)
		if (!strcmp(de.name, ".") || !strcmp(de.name, ".."))
 114:	00001a17          	auipc	s4,0x1
 118:	92ca0a13          	addi	s4,s4,-1748 # a40 <malloc+0x156>
 11c:	00001a97          	auipc	s5,0x1
 120:	92ca8a93          	addi	s5,s5,-1748 # a48 <malloc+0x15e>
	while (read(fd, &de, sizeof(de)) == sizeof(de)) {
 124:	4641                	li	a2,16
 126:	db040593          	addi	a1,s0,-592
 12a:	8526                	mv	a0,s1
 12c:	00000097          	auipc	ra,0x0
 130:	3a4080e7          	jalr	932(ra) # 4d0 <read>
 134:	47c1                	li	a5,16
 136:	f2f51ee3          	bne	a0,a5,72 <find+0x72>
		if (de.inum == 0) 
 13a:	db045783          	lhu	a5,-592(s0)
 13e:	d3fd                	beqz	a5,124 <find+0x124>
		if (!strcmp(de.name, ".") || !strcmp(de.name, ".."))
 140:	85d2                	mv	a1,s4
 142:	db240513          	addi	a0,s0,-590
 146:	00000097          	auipc	ra,0x0
 14a:	122080e7          	jalr	290(ra) # 268 <strcmp>
 14e:	d979                	beqz	a0,124 <find+0x124>
 150:	85d6                	mv	a1,s5
 152:	db240513          	addi	a0,s0,-590
 156:	00000097          	auipc	ra,0x0
 15a:	112080e7          	jalr	274(ra) # 268 <strcmp>
 15e:	d179                	beqz	a0,124 <find+0x124>
		memmove(p, de.name, DIRSIZ);
 160:	4639                	li	a2,14
 162:	db240593          	addi	a1,s0,-590
 166:	855a                	mv	a0,s6
 168:	00000097          	auipc	ra,0x0
 16c:	29e080e7          	jalr	670(ra) # 406 <memmove>
		p[DIRSIZ] = 0;
 170:	000907a3          	sb	zero,15(s2)
		if (stat(buf, &st) < 0) {
 174:	d9840593          	addi	a1,s0,-616
 178:	dc040513          	addi	a0,s0,-576
 17c:	00000097          	auipc	ra,0x0
 180:	1fc080e7          	jalr	508(ra) # 378 <stat>
 184:	04054f63          	bltz	a0,1e2 <find+0x1e2>
		if (st.type == T_DIR) {
 188:	da041783          	lh	a5,-608(s0)
 18c:	0007869b          	sext.w	a3,a5
 190:	4705                	li	a4,1
 192:	06e68463          	beq	a3,a4,1fa <find+0x1fa>
		} else if (st.type == T_FILE && !strcmp(de.name, file)) {
 196:	2781                	sext.w	a5,a5
 198:	4709                	li	a4,2
 19a:	f8e795e3          	bne	a5,a4,124 <find+0x124>
 19e:	85ce                	mv	a1,s3
 1a0:	db240513          	addi	a0,s0,-590
 1a4:	00000097          	auipc	ra,0x0
 1a8:	0c4080e7          	jalr	196(ra) # 268 <strcmp>
 1ac:	fd25                	bnez	a0,124 <find+0x124>
			printf("%s\n", buf);
 1ae:	dc040593          	addi	a1,s0,-576
 1b2:	00001517          	auipc	a0,0x1
 1b6:	89e50513          	addi	a0,a0,-1890 # a50 <malloc+0x166>
 1ba:	00000097          	auipc	ra,0x0
 1be:	678080e7          	jalr	1656(ra) # 832 <printf>
 1c2:	b78d                	j	124 <find+0x124>
		fprintf(2, "find: directory too long\n");
 1c4:	00001597          	auipc	a1,0x1
 1c8:	85c58593          	addi	a1,a1,-1956 # a20 <malloc+0x136>
 1cc:	4509                	li	a0,2
 1ce:	00000097          	auipc	ra,0x0
 1d2:	636080e7          	jalr	1590(ra) # 804 <fprintf>
		close(fd);
 1d6:	8526                	mv	a0,s1
 1d8:	00000097          	auipc	ra,0x0
 1dc:	308080e7          	jalr	776(ra) # 4e0 <close>
		return;
 1e0:	bd49                	j	72 <find+0x72>
			fprintf(2, "find: cannot stat %s\n", buf);
 1e2:	dc040613          	addi	a2,s0,-576
 1e6:	00001597          	auipc	a1,0x1
 1ea:	80258593          	addi	a1,a1,-2046 # 9e8 <malloc+0xfe>
 1ee:	4509                	li	a0,2
 1f0:	00000097          	auipc	ra,0x0
 1f4:	614080e7          	jalr	1556(ra) # 804 <fprintf>
			continue;
 1f8:	b735                	j	124 <find+0x124>
			find(buf, file);
 1fa:	85ce                	mv	a1,s3
 1fc:	dc040513          	addi	a0,s0,-576
 200:	00000097          	auipc	ra,0x0
 204:	e00080e7          	jalr	-512(ra) # 0 <find>
 208:	bf31                	j	124 <find+0x124>

000000000000020a <main>:

int
main(int argc, char *argv[])
{
 20a:	1141                	addi	sp,sp,-16
 20c:	e406                	sd	ra,8(sp)
 20e:	e022                	sd	s0,0(sp)
 210:	0800                	addi	s0,sp,16
	if (argc != 3) {
 212:	470d                	li	a4,3
 214:	02e50063          	beq	a0,a4,234 <main+0x2a>
		fprintf(2, "usage: find dirName fileName");
 218:	00001597          	auipc	a1,0x1
 21c:	84058593          	addi	a1,a1,-1984 # a58 <malloc+0x16e>
 220:	4509                	li	a0,2
 222:	00000097          	auipc	ra,0x0
 226:	5e2080e7          	jalr	1506(ra) # 804 <fprintf>
		exit(1);
 22a:	4505                	li	a0,1
 22c:	00000097          	auipc	ra,0x0
 230:	28c080e7          	jalr	652(ra) # 4b8 <exit>
 234:	87ae                	mv	a5,a1
	}
	find(argv[1], argv[2]);
 236:	698c                	ld	a1,16(a1)
 238:	6788                	ld	a0,8(a5)
 23a:	00000097          	auipc	ra,0x0
 23e:	dc6080e7          	jalr	-570(ra) # 0 <find>
	exit(0);
 242:	4501                	li	a0,0
 244:	00000097          	auipc	ra,0x0
 248:	274080e7          	jalr	628(ra) # 4b8 <exit>

000000000000024c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 24c:	1141                	addi	sp,sp,-16
 24e:	e422                	sd	s0,8(sp)
 250:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 252:	87aa                	mv	a5,a0
 254:	0585                	addi	a1,a1,1
 256:	0785                	addi	a5,a5,1
 258:	fff5c703          	lbu	a4,-1(a1)
 25c:	fee78fa3          	sb	a4,-1(a5)
 260:	fb75                	bnez	a4,254 <strcpy+0x8>
    ;
  return os;
}
 262:	6422                	ld	s0,8(sp)
 264:	0141                	addi	sp,sp,16
 266:	8082                	ret

0000000000000268 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e422                	sd	s0,8(sp)
 26c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 26e:	00054783          	lbu	a5,0(a0)
 272:	cb91                	beqz	a5,286 <strcmp+0x1e>
 274:	0005c703          	lbu	a4,0(a1)
 278:	00f71763          	bne	a4,a5,286 <strcmp+0x1e>
    p++, q++;
 27c:	0505                	addi	a0,a0,1
 27e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 280:	00054783          	lbu	a5,0(a0)
 284:	fbe5                	bnez	a5,274 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 286:	0005c503          	lbu	a0,0(a1)
}
 28a:	40a7853b          	subw	a0,a5,a0
 28e:	6422                	ld	s0,8(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret

0000000000000294 <strlen>:

uint
strlen(const char *s)
{
 294:	1141                	addi	sp,sp,-16
 296:	e422                	sd	s0,8(sp)
 298:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 29a:	00054783          	lbu	a5,0(a0)
 29e:	cf91                	beqz	a5,2ba <strlen+0x26>
 2a0:	0505                	addi	a0,a0,1
 2a2:	87aa                	mv	a5,a0
 2a4:	4685                	li	a3,1
 2a6:	9e89                	subw	a3,a3,a0
 2a8:	00f6853b          	addw	a0,a3,a5
 2ac:	0785                	addi	a5,a5,1
 2ae:	fff7c703          	lbu	a4,-1(a5)
 2b2:	fb7d                	bnez	a4,2a8 <strlen+0x14>
    ;
  return n;
}
 2b4:	6422                	ld	s0,8(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret
  for(n = 0; s[n]; n++)
 2ba:	4501                	li	a0,0
 2bc:	bfe5                	j	2b4 <strlen+0x20>

00000000000002be <memset>:

void*
memset(void *dst, int c, uint n)
{
 2be:	1141                	addi	sp,sp,-16
 2c0:	e422                	sd	s0,8(sp)
 2c2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2c4:	ca19                	beqz	a2,2da <memset+0x1c>
 2c6:	87aa                	mv	a5,a0
 2c8:	1602                	slli	a2,a2,0x20
 2ca:	9201                	srli	a2,a2,0x20
 2cc:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2d0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2d4:	0785                	addi	a5,a5,1
 2d6:	fee79de3          	bne	a5,a4,2d0 <memset+0x12>
  }
  return dst;
}
 2da:	6422                	ld	s0,8(sp)
 2dc:	0141                	addi	sp,sp,16
 2de:	8082                	ret

00000000000002e0 <strchr>:

char*
strchr(const char *s, char c)
{
 2e0:	1141                	addi	sp,sp,-16
 2e2:	e422                	sd	s0,8(sp)
 2e4:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2e6:	00054783          	lbu	a5,0(a0)
 2ea:	cb99                	beqz	a5,300 <strchr+0x20>
    if(*s == c)
 2ec:	00f58763          	beq	a1,a5,2fa <strchr+0x1a>
  for(; *s; s++)
 2f0:	0505                	addi	a0,a0,1
 2f2:	00054783          	lbu	a5,0(a0)
 2f6:	fbfd                	bnez	a5,2ec <strchr+0xc>
      return (char*)s;
  return 0;
 2f8:	4501                	li	a0,0
}
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret
  return 0;
 300:	4501                	li	a0,0
 302:	bfe5                	j	2fa <strchr+0x1a>

0000000000000304 <gets>:

char*
gets(char *buf, int max)
{
 304:	711d                	addi	sp,sp,-96
 306:	ec86                	sd	ra,88(sp)
 308:	e8a2                	sd	s0,80(sp)
 30a:	e4a6                	sd	s1,72(sp)
 30c:	e0ca                	sd	s2,64(sp)
 30e:	fc4e                	sd	s3,56(sp)
 310:	f852                	sd	s4,48(sp)
 312:	f456                	sd	s5,40(sp)
 314:	f05a                	sd	s6,32(sp)
 316:	ec5e                	sd	s7,24(sp)
 318:	1080                	addi	s0,sp,96
 31a:	8baa                	mv	s7,a0
 31c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 31e:	892a                	mv	s2,a0
 320:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 322:	4aa9                	li	s5,10
 324:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 326:	89a6                	mv	s3,s1
 328:	2485                	addiw	s1,s1,1
 32a:	0344d863          	bge	s1,s4,35a <gets+0x56>
    cc = read(0, &c, 1);
 32e:	4605                	li	a2,1
 330:	faf40593          	addi	a1,s0,-81
 334:	4501                	li	a0,0
 336:	00000097          	auipc	ra,0x0
 33a:	19a080e7          	jalr	410(ra) # 4d0 <read>
    if(cc < 1)
 33e:	00a05e63          	blez	a0,35a <gets+0x56>
    buf[i++] = c;
 342:	faf44783          	lbu	a5,-81(s0)
 346:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 34a:	01578763          	beq	a5,s5,358 <gets+0x54>
 34e:	0905                	addi	s2,s2,1
 350:	fd679be3          	bne	a5,s6,326 <gets+0x22>
  for(i=0; i+1 < max; ){
 354:	89a6                	mv	s3,s1
 356:	a011                	j	35a <gets+0x56>
 358:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 35a:	99de                	add	s3,s3,s7
 35c:	00098023          	sb	zero,0(s3)
  return buf;
}
 360:	855e                	mv	a0,s7
 362:	60e6                	ld	ra,88(sp)
 364:	6446                	ld	s0,80(sp)
 366:	64a6                	ld	s1,72(sp)
 368:	6906                	ld	s2,64(sp)
 36a:	79e2                	ld	s3,56(sp)
 36c:	7a42                	ld	s4,48(sp)
 36e:	7aa2                	ld	s5,40(sp)
 370:	7b02                	ld	s6,32(sp)
 372:	6be2                	ld	s7,24(sp)
 374:	6125                	addi	sp,sp,96
 376:	8082                	ret

0000000000000378 <stat>:

int
stat(const char *n, struct stat *st)
{
 378:	1101                	addi	sp,sp,-32
 37a:	ec06                	sd	ra,24(sp)
 37c:	e822                	sd	s0,16(sp)
 37e:	e426                	sd	s1,8(sp)
 380:	e04a                	sd	s2,0(sp)
 382:	1000                	addi	s0,sp,32
 384:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 386:	4581                	li	a1,0
 388:	00000097          	auipc	ra,0x0
 38c:	170080e7          	jalr	368(ra) # 4f8 <open>
  if(fd < 0)
 390:	02054563          	bltz	a0,3ba <stat+0x42>
 394:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 396:	85ca                	mv	a1,s2
 398:	00000097          	auipc	ra,0x0
 39c:	178080e7          	jalr	376(ra) # 510 <fstat>
 3a0:	892a                	mv	s2,a0
  close(fd);
 3a2:	8526                	mv	a0,s1
 3a4:	00000097          	auipc	ra,0x0
 3a8:	13c080e7          	jalr	316(ra) # 4e0 <close>
  return r;
}
 3ac:	854a                	mv	a0,s2
 3ae:	60e2                	ld	ra,24(sp)
 3b0:	6442                	ld	s0,16(sp)
 3b2:	64a2                	ld	s1,8(sp)
 3b4:	6902                	ld	s2,0(sp)
 3b6:	6105                	addi	sp,sp,32
 3b8:	8082                	ret
    return -1;
 3ba:	597d                	li	s2,-1
 3bc:	bfc5                	j	3ac <stat+0x34>

00000000000003be <atoi>:

int
atoi(const char *s)
{
 3be:	1141                	addi	sp,sp,-16
 3c0:	e422                	sd	s0,8(sp)
 3c2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c4:	00054683          	lbu	a3,0(a0)
 3c8:	fd06879b          	addiw	a5,a3,-48
 3cc:	0ff7f793          	zext.b	a5,a5
 3d0:	4625                	li	a2,9
 3d2:	02f66863          	bltu	a2,a5,402 <atoi+0x44>
 3d6:	872a                	mv	a4,a0
  n = 0;
 3d8:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3da:	0705                	addi	a4,a4,1
 3dc:	0025179b          	slliw	a5,a0,0x2
 3e0:	9fa9                	addw	a5,a5,a0
 3e2:	0017979b          	slliw	a5,a5,0x1
 3e6:	9fb5                	addw	a5,a5,a3
 3e8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3ec:	00074683          	lbu	a3,0(a4)
 3f0:	fd06879b          	addiw	a5,a3,-48
 3f4:	0ff7f793          	zext.b	a5,a5
 3f8:	fef671e3          	bgeu	a2,a5,3da <atoi+0x1c>
  return n;
}
 3fc:	6422                	ld	s0,8(sp)
 3fe:	0141                	addi	sp,sp,16
 400:	8082                	ret
  n = 0;
 402:	4501                	li	a0,0
 404:	bfe5                	j	3fc <atoi+0x3e>

0000000000000406 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 406:	1141                	addi	sp,sp,-16
 408:	e422                	sd	s0,8(sp)
 40a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 40c:	02b57463          	bgeu	a0,a1,434 <memmove+0x2e>
    while(n-- > 0)
 410:	00c05f63          	blez	a2,42e <memmove+0x28>
 414:	1602                	slli	a2,a2,0x20
 416:	9201                	srli	a2,a2,0x20
 418:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 41c:	872a                	mv	a4,a0
      *dst++ = *src++;
 41e:	0585                	addi	a1,a1,1
 420:	0705                	addi	a4,a4,1
 422:	fff5c683          	lbu	a3,-1(a1)
 426:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 42a:	fee79ae3          	bne	a5,a4,41e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 42e:	6422                	ld	s0,8(sp)
 430:	0141                	addi	sp,sp,16
 432:	8082                	ret
    dst += n;
 434:	00c50733          	add	a4,a0,a2
    src += n;
 438:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 43a:	fec05ae3          	blez	a2,42e <memmove+0x28>
 43e:	fff6079b          	addiw	a5,a2,-1
 442:	1782                	slli	a5,a5,0x20
 444:	9381                	srli	a5,a5,0x20
 446:	fff7c793          	not	a5,a5
 44a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 44c:	15fd                	addi	a1,a1,-1
 44e:	177d                	addi	a4,a4,-1
 450:	0005c683          	lbu	a3,0(a1)
 454:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 458:	fee79ae3          	bne	a5,a4,44c <memmove+0x46>
 45c:	bfc9                	j	42e <memmove+0x28>

000000000000045e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 45e:	1141                	addi	sp,sp,-16
 460:	e422                	sd	s0,8(sp)
 462:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 464:	ca05                	beqz	a2,494 <memcmp+0x36>
 466:	fff6069b          	addiw	a3,a2,-1
 46a:	1682                	slli	a3,a3,0x20
 46c:	9281                	srli	a3,a3,0x20
 46e:	0685                	addi	a3,a3,1
 470:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 472:	00054783          	lbu	a5,0(a0)
 476:	0005c703          	lbu	a4,0(a1)
 47a:	00e79863          	bne	a5,a4,48a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 47e:	0505                	addi	a0,a0,1
    p2++;
 480:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 482:	fed518e3          	bne	a0,a3,472 <memcmp+0x14>
  }
  return 0;
 486:	4501                	li	a0,0
 488:	a019                	j	48e <memcmp+0x30>
      return *p1 - *p2;
 48a:	40e7853b          	subw	a0,a5,a4
}
 48e:	6422                	ld	s0,8(sp)
 490:	0141                	addi	sp,sp,16
 492:	8082                	ret
  return 0;
 494:	4501                	li	a0,0
 496:	bfe5                	j	48e <memcmp+0x30>

0000000000000498 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 498:	1141                	addi	sp,sp,-16
 49a:	e406                	sd	ra,8(sp)
 49c:	e022                	sd	s0,0(sp)
 49e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4a0:	00000097          	auipc	ra,0x0
 4a4:	f66080e7          	jalr	-154(ra) # 406 <memmove>
}
 4a8:	60a2                	ld	ra,8(sp)
 4aa:	6402                	ld	s0,0(sp)
 4ac:	0141                	addi	sp,sp,16
 4ae:	8082                	ret

00000000000004b0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4b0:	4885                	li	a7,1
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4b8:	4889                	li	a7,2
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4c0:	488d                	li	a7,3
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4c8:	4891                	li	a7,4
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <read>:
.global read
read:
 li a7, SYS_read
 4d0:	4895                	li	a7,5
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <write>:
.global write
write:
 li a7, SYS_write
 4d8:	48c1                	li	a7,16
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <close>:
.global close
close:
 li a7, SYS_close
 4e0:	48d5                	li	a7,21
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4e8:	4899                	li	a7,6
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4f0:	489d                	li	a7,7
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <open>:
.global open
open:
 li a7, SYS_open
 4f8:	48bd                	li	a7,15
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 500:	48c5                	li	a7,17
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 508:	48c9                	li	a7,18
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 510:	48a1                	li	a7,8
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <link>:
.global link
link:
 li a7, SYS_link
 518:	48cd                	li	a7,19
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 520:	48d1                	li	a7,20
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 528:	48a5                	li	a7,9
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <dup>:
.global dup
dup:
 li a7, SYS_dup
 530:	48a9                	li	a7,10
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 538:	48ad                	li	a7,11
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 540:	48b1                	li	a7,12
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 548:	48b5                	li	a7,13
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 550:	48b9                	li	a7,14
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 558:	1101                	addi	sp,sp,-32
 55a:	ec06                	sd	ra,24(sp)
 55c:	e822                	sd	s0,16(sp)
 55e:	1000                	addi	s0,sp,32
 560:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 564:	4605                	li	a2,1
 566:	fef40593          	addi	a1,s0,-17
 56a:	00000097          	auipc	ra,0x0
 56e:	f6e080e7          	jalr	-146(ra) # 4d8 <write>
}
 572:	60e2                	ld	ra,24(sp)
 574:	6442                	ld	s0,16(sp)
 576:	6105                	addi	sp,sp,32
 578:	8082                	ret

000000000000057a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 57a:	7139                	addi	sp,sp,-64
 57c:	fc06                	sd	ra,56(sp)
 57e:	f822                	sd	s0,48(sp)
 580:	f426                	sd	s1,40(sp)
 582:	f04a                	sd	s2,32(sp)
 584:	ec4e                	sd	s3,24(sp)
 586:	0080                	addi	s0,sp,64
 588:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 58a:	c299                	beqz	a3,590 <printint+0x16>
 58c:	0805c963          	bltz	a1,61e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 590:	2581                	sext.w	a1,a1
  neg = 0;
 592:	4881                	li	a7,0
 594:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 598:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 59a:	2601                	sext.w	a2,a2
 59c:	00000517          	auipc	a0,0x0
 5a0:	53c50513          	addi	a0,a0,1340 # ad8 <digits>
 5a4:	883a                	mv	a6,a4
 5a6:	2705                	addiw	a4,a4,1
 5a8:	02c5f7bb          	remuw	a5,a1,a2
 5ac:	1782                	slli	a5,a5,0x20
 5ae:	9381                	srli	a5,a5,0x20
 5b0:	97aa                	add	a5,a5,a0
 5b2:	0007c783          	lbu	a5,0(a5)
 5b6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5ba:	0005879b          	sext.w	a5,a1
 5be:	02c5d5bb          	divuw	a1,a1,a2
 5c2:	0685                	addi	a3,a3,1
 5c4:	fec7f0e3          	bgeu	a5,a2,5a4 <printint+0x2a>
  if(neg)
 5c8:	00088c63          	beqz	a7,5e0 <printint+0x66>
    buf[i++] = '-';
 5cc:	fd070793          	addi	a5,a4,-48
 5d0:	00878733          	add	a4,a5,s0
 5d4:	02d00793          	li	a5,45
 5d8:	fef70823          	sb	a5,-16(a4)
 5dc:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5e0:	02e05863          	blez	a4,610 <printint+0x96>
 5e4:	fc040793          	addi	a5,s0,-64
 5e8:	00e78933          	add	s2,a5,a4
 5ec:	fff78993          	addi	s3,a5,-1
 5f0:	99ba                	add	s3,s3,a4
 5f2:	377d                	addiw	a4,a4,-1
 5f4:	1702                	slli	a4,a4,0x20
 5f6:	9301                	srli	a4,a4,0x20
 5f8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5fc:	fff94583          	lbu	a1,-1(s2)
 600:	8526                	mv	a0,s1
 602:	00000097          	auipc	ra,0x0
 606:	f56080e7          	jalr	-170(ra) # 558 <putc>
  while(--i >= 0)
 60a:	197d                	addi	s2,s2,-1
 60c:	ff3918e3          	bne	s2,s3,5fc <printint+0x82>
}
 610:	70e2                	ld	ra,56(sp)
 612:	7442                	ld	s0,48(sp)
 614:	74a2                	ld	s1,40(sp)
 616:	7902                	ld	s2,32(sp)
 618:	69e2                	ld	s3,24(sp)
 61a:	6121                	addi	sp,sp,64
 61c:	8082                	ret
    x = -xx;
 61e:	40b005bb          	negw	a1,a1
    neg = 1;
 622:	4885                	li	a7,1
    x = -xx;
 624:	bf85                	j	594 <printint+0x1a>

0000000000000626 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 626:	7119                	addi	sp,sp,-128
 628:	fc86                	sd	ra,120(sp)
 62a:	f8a2                	sd	s0,112(sp)
 62c:	f4a6                	sd	s1,104(sp)
 62e:	f0ca                	sd	s2,96(sp)
 630:	ecce                	sd	s3,88(sp)
 632:	e8d2                	sd	s4,80(sp)
 634:	e4d6                	sd	s5,72(sp)
 636:	e0da                	sd	s6,64(sp)
 638:	fc5e                	sd	s7,56(sp)
 63a:	f862                	sd	s8,48(sp)
 63c:	f466                	sd	s9,40(sp)
 63e:	f06a                	sd	s10,32(sp)
 640:	ec6e                	sd	s11,24(sp)
 642:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 644:	0005c903          	lbu	s2,0(a1)
 648:	18090f63          	beqz	s2,7e6 <vprintf+0x1c0>
 64c:	8aaa                	mv	s5,a0
 64e:	8b32                	mv	s6,a2
 650:	00158493          	addi	s1,a1,1
  state = 0;
 654:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 656:	02500a13          	li	s4,37
 65a:	4c55                	li	s8,21
 65c:	00000c97          	auipc	s9,0x0
 660:	424c8c93          	addi	s9,s9,1060 # a80 <malloc+0x196>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 664:	02800d93          	li	s11,40
  putc(fd, 'x');
 668:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 66a:	00000b97          	auipc	s7,0x0
 66e:	46eb8b93          	addi	s7,s7,1134 # ad8 <digits>
 672:	a839                	j	690 <vprintf+0x6a>
        putc(fd, c);
 674:	85ca                	mv	a1,s2
 676:	8556                	mv	a0,s5
 678:	00000097          	auipc	ra,0x0
 67c:	ee0080e7          	jalr	-288(ra) # 558 <putc>
 680:	a019                	j	686 <vprintf+0x60>
    } else if(state == '%'){
 682:	01498d63          	beq	s3,s4,69c <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 686:	0485                	addi	s1,s1,1
 688:	fff4c903          	lbu	s2,-1(s1)
 68c:	14090d63          	beqz	s2,7e6 <vprintf+0x1c0>
    if(state == 0){
 690:	fe0999e3          	bnez	s3,682 <vprintf+0x5c>
      if(c == '%'){
 694:	ff4910e3          	bne	s2,s4,674 <vprintf+0x4e>
        state = '%';
 698:	89d2                	mv	s3,s4
 69a:	b7f5                	j	686 <vprintf+0x60>
      if(c == 'd'){
 69c:	11490c63          	beq	s2,s4,7b4 <vprintf+0x18e>
 6a0:	f9d9079b          	addiw	a5,s2,-99
 6a4:	0ff7f793          	zext.b	a5,a5
 6a8:	10fc6e63          	bltu	s8,a5,7c4 <vprintf+0x19e>
 6ac:	f9d9079b          	addiw	a5,s2,-99
 6b0:	0ff7f713          	zext.b	a4,a5
 6b4:	10ec6863          	bltu	s8,a4,7c4 <vprintf+0x19e>
 6b8:	00271793          	slli	a5,a4,0x2
 6bc:	97e6                	add	a5,a5,s9
 6be:	439c                	lw	a5,0(a5)
 6c0:	97e6                	add	a5,a5,s9
 6c2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 6c4:	008b0913          	addi	s2,s6,8
 6c8:	4685                	li	a3,1
 6ca:	4629                	li	a2,10
 6cc:	000b2583          	lw	a1,0(s6)
 6d0:	8556                	mv	a0,s5
 6d2:	00000097          	auipc	ra,0x0
 6d6:	ea8080e7          	jalr	-344(ra) # 57a <printint>
 6da:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6dc:	4981                	li	s3,0
 6de:	b765                	j	686 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e0:	008b0913          	addi	s2,s6,8
 6e4:	4681                	li	a3,0
 6e6:	4629                	li	a2,10
 6e8:	000b2583          	lw	a1,0(s6)
 6ec:	8556                	mv	a0,s5
 6ee:	00000097          	auipc	ra,0x0
 6f2:	e8c080e7          	jalr	-372(ra) # 57a <printint>
 6f6:	8b4a                	mv	s6,s2
      state = 0;
 6f8:	4981                	li	s3,0
 6fa:	b771                	j	686 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6fc:	008b0913          	addi	s2,s6,8
 700:	4681                	li	a3,0
 702:	866a                	mv	a2,s10
 704:	000b2583          	lw	a1,0(s6)
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	e70080e7          	jalr	-400(ra) # 57a <printint>
 712:	8b4a                	mv	s6,s2
      state = 0;
 714:	4981                	li	s3,0
 716:	bf85                	j	686 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 718:	008b0793          	addi	a5,s6,8
 71c:	f8f43423          	sd	a5,-120(s0)
 720:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 724:	03000593          	li	a1,48
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	e2e080e7          	jalr	-466(ra) # 558 <putc>
  putc(fd, 'x');
 732:	07800593          	li	a1,120
 736:	8556                	mv	a0,s5
 738:	00000097          	auipc	ra,0x0
 73c:	e20080e7          	jalr	-480(ra) # 558 <putc>
 740:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 742:	03c9d793          	srli	a5,s3,0x3c
 746:	97de                	add	a5,a5,s7
 748:	0007c583          	lbu	a1,0(a5)
 74c:	8556                	mv	a0,s5
 74e:	00000097          	auipc	ra,0x0
 752:	e0a080e7          	jalr	-502(ra) # 558 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 756:	0992                	slli	s3,s3,0x4
 758:	397d                	addiw	s2,s2,-1
 75a:	fe0914e3          	bnez	s2,742 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 75e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 762:	4981                	li	s3,0
 764:	b70d                	j	686 <vprintf+0x60>
        s = va_arg(ap, char*);
 766:	008b0913          	addi	s2,s6,8
 76a:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 76e:	02098163          	beqz	s3,790 <vprintf+0x16a>
        while(*s != 0){
 772:	0009c583          	lbu	a1,0(s3)
 776:	c5ad                	beqz	a1,7e0 <vprintf+0x1ba>
          putc(fd, *s);
 778:	8556                	mv	a0,s5
 77a:	00000097          	auipc	ra,0x0
 77e:	dde080e7          	jalr	-546(ra) # 558 <putc>
          s++;
 782:	0985                	addi	s3,s3,1
        while(*s != 0){
 784:	0009c583          	lbu	a1,0(s3)
 788:	f9e5                	bnez	a1,778 <vprintf+0x152>
        s = va_arg(ap, char*);
 78a:	8b4a                	mv	s6,s2
      state = 0;
 78c:	4981                	li	s3,0
 78e:	bde5                	j	686 <vprintf+0x60>
          s = "(null)";
 790:	00000997          	auipc	s3,0x0
 794:	2e898993          	addi	s3,s3,744 # a78 <malloc+0x18e>
        while(*s != 0){
 798:	85ee                	mv	a1,s11
 79a:	bff9                	j	778 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 79c:	008b0913          	addi	s2,s6,8
 7a0:	000b4583          	lbu	a1,0(s6)
 7a4:	8556                	mv	a0,s5
 7a6:	00000097          	auipc	ra,0x0
 7aa:	db2080e7          	jalr	-590(ra) # 558 <putc>
 7ae:	8b4a                	mv	s6,s2
      state = 0;
 7b0:	4981                	li	s3,0
 7b2:	bdd1                	j	686 <vprintf+0x60>
        putc(fd, c);
 7b4:	85d2                	mv	a1,s4
 7b6:	8556                	mv	a0,s5
 7b8:	00000097          	auipc	ra,0x0
 7bc:	da0080e7          	jalr	-608(ra) # 558 <putc>
      state = 0;
 7c0:	4981                	li	s3,0
 7c2:	b5d1                	j	686 <vprintf+0x60>
        putc(fd, '%');
 7c4:	85d2                	mv	a1,s4
 7c6:	8556                	mv	a0,s5
 7c8:	00000097          	auipc	ra,0x0
 7cc:	d90080e7          	jalr	-624(ra) # 558 <putc>
        putc(fd, c);
 7d0:	85ca                	mv	a1,s2
 7d2:	8556                	mv	a0,s5
 7d4:	00000097          	auipc	ra,0x0
 7d8:	d84080e7          	jalr	-636(ra) # 558 <putc>
      state = 0;
 7dc:	4981                	li	s3,0
 7de:	b565                	j	686 <vprintf+0x60>
        s = va_arg(ap, char*);
 7e0:	8b4a                	mv	s6,s2
      state = 0;
 7e2:	4981                	li	s3,0
 7e4:	b54d                	j	686 <vprintf+0x60>
    }
  }
}
 7e6:	70e6                	ld	ra,120(sp)
 7e8:	7446                	ld	s0,112(sp)
 7ea:	74a6                	ld	s1,104(sp)
 7ec:	7906                	ld	s2,96(sp)
 7ee:	69e6                	ld	s3,88(sp)
 7f0:	6a46                	ld	s4,80(sp)
 7f2:	6aa6                	ld	s5,72(sp)
 7f4:	6b06                	ld	s6,64(sp)
 7f6:	7be2                	ld	s7,56(sp)
 7f8:	7c42                	ld	s8,48(sp)
 7fa:	7ca2                	ld	s9,40(sp)
 7fc:	7d02                	ld	s10,32(sp)
 7fe:	6de2                	ld	s11,24(sp)
 800:	6109                	addi	sp,sp,128
 802:	8082                	ret

0000000000000804 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 804:	715d                	addi	sp,sp,-80
 806:	ec06                	sd	ra,24(sp)
 808:	e822                	sd	s0,16(sp)
 80a:	1000                	addi	s0,sp,32
 80c:	e010                	sd	a2,0(s0)
 80e:	e414                	sd	a3,8(s0)
 810:	e818                	sd	a4,16(s0)
 812:	ec1c                	sd	a5,24(s0)
 814:	03043023          	sd	a6,32(s0)
 818:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 81c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 820:	8622                	mv	a2,s0
 822:	00000097          	auipc	ra,0x0
 826:	e04080e7          	jalr	-508(ra) # 626 <vprintf>
}
 82a:	60e2                	ld	ra,24(sp)
 82c:	6442                	ld	s0,16(sp)
 82e:	6161                	addi	sp,sp,80
 830:	8082                	ret

0000000000000832 <printf>:

void
printf(const char *fmt, ...)
{
 832:	711d                	addi	sp,sp,-96
 834:	ec06                	sd	ra,24(sp)
 836:	e822                	sd	s0,16(sp)
 838:	1000                	addi	s0,sp,32
 83a:	e40c                	sd	a1,8(s0)
 83c:	e810                	sd	a2,16(s0)
 83e:	ec14                	sd	a3,24(s0)
 840:	f018                	sd	a4,32(s0)
 842:	f41c                	sd	a5,40(s0)
 844:	03043823          	sd	a6,48(s0)
 848:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 84c:	00840613          	addi	a2,s0,8
 850:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 854:	85aa                	mv	a1,a0
 856:	4505                	li	a0,1
 858:	00000097          	auipc	ra,0x0
 85c:	dce080e7          	jalr	-562(ra) # 626 <vprintf>
}
 860:	60e2                	ld	ra,24(sp)
 862:	6442                	ld	s0,16(sp)
 864:	6125                	addi	sp,sp,96
 866:	8082                	ret

0000000000000868 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 868:	1141                	addi	sp,sp,-16
 86a:	e422                	sd	s0,8(sp)
 86c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 86e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 872:	00000797          	auipc	a5,0x0
 876:	27e7b783          	ld	a5,638(a5) # af0 <freep>
 87a:	a02d                	j	8a4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 87c:	4618                	lw	a4,8(a2)
 87e:	9f2d                	addw	a4,a4,a1
 880:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 884:	6398                	ld	a4,0(a5)
 886:	6310                	ld	a2,0(a4)
 888:	a83d                	j	8c6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 88a:	ff852703          	lw	a4,-8(a0)
 88e:	9f31                	addw	a4,a4,a2
 890:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 892:	ff053683          	ld	a3,-16(a0)
 896:	a091                	j	8da <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 898:	6398                	ld	a4,0(a5)
 89a:	00e7e463          	bltu	a5,a4,8a2 <free+0x3a>
 89e:	00e6ea63          	bltu	a3,a4,8b2 <free+0x4a>
{
 8a2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a4:	fed7fae3          	bgeu	a5,a3,898 <free+0x30>
 8a8:	6398                	ld	a4,0(a5)
 8aa:	00e6e463          	bltu	a3,a4,8b2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ae:	fee7eae3          	bltu	a5,a4,8a2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8b2:	ff852583          	lw	a1,-8(a0)
 8b6:	6390                	ld	a2,0(a5)
 8b8:	02059813          	slli	a6,a1,0x20
 8bc:	01c85713          	srli	a4,a6,0x1c
 8c0:	9736                	add	a4,a4,a3
 8c2:	fae60de3          	beq	a2,a4,87c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8c6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8ca:	4790                	lw	a2,8(a5)
 8cc:	02061593          	slli	a1,a2,0x20
 8d0:	01c5d713          	srli	a4,a1,0x1c
 8d4:	973e                	add	a4,a4,a5
 8d6:	fae68ae3          	beq	a3,a4,88a <free+0x22>
    p->s.ptr = bp->s.ptr;
 8da:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8dc:	00000717          	auipc	a4,0x0
 8e0:	20f73a23          	sd	a5,532(a4) # af0 <freep>
}
 8e4:	6422                	ld	s0,8(sp)
 8e6:	0141                	addi	sp,sp,16
 8e8:	8082                	ret

00000000000008ea <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8ea:	7139                	addi	sp,sp,-64
 8ec:	fc06                	sd	ra,56(sp)
 8ee:	f822                	sd	s0,48(sp)
 8f0:	f426                	sd	s1,40(sp)
 8f2:	f04a                	sd	s2,32(sp)
 8f4:	ec4e                	sd	s3,24(sp)
 8f6:	e852                	sd	s4,16(sp)
 8f8:	e456                	sd	s5,8(sp)
 8fa:	e05a                	sd	s6,0(sp)
 8fc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8fe:	02051493          	slli	s1,a0,0x20
 902:	9081                	srli	s1,s1,0x20
 904:	04bd                	addi	s1,s1,15
 906:	8091                	srli	s1,s1,0x4
 908:	0014899b          	addiw	s3,s1,1
 90c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 90e:	00000517          	auipc	a0,0x0
 912:	1e253503          	ld	a0,482(a0) # af0 <freep>
 916:	c515                	beqz	a0,942 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 918:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 91a:	4798                	lw	a4,8(a5)
 91c:	02977f63          	bgeu	a4,s1,95a <malloc+0x70>
 920:	8a4e                	mv	s4,s3
 922:	0009871b          	sext.w	a4,s3
 926:	6685                	lui	a3,0x1
 928:	00d77363          	bgeu	a4,a3,92e <malloc+0x44>
 92c:	6a05                	lui	s4,0x1
 92e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 932:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 936:	00000917          	auipc	s2,0x0
 93a:	1ba90913          	addi	s2,s2,442 # af0 <freep>
  if(p == (char*)-1)
 93e:	5afd                	li	s5,-1
 940:	a895                	j	9b4 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 942:	00000797          	auipc	a5,0x0
 946:	1b678793          	addi	a5,a5,438 # af8 <base>
 94a:	00000717          	auipc	a4,0x0
 94e:	1af73323          	sd	a5,422(a4) # af0 <freep>
 952:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 954:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 958:	b7e1                	j	920 <malloc+0x36>
      if(p->s.size == nunits)
 95a:	02e48c63          	beq	s1,a4,992 <malloc+0xa8>
        p->s.size -= nunits;
 95e:	4137073b          	subw	a4,a4,s3
 962:	c798                	sw	a4,8(a5)
        p += p->s.size;
 964:	02071693          	slli	a3,a4,0x20
 968:	01c6d713          	srli	a4,a3,0x1c
 96c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 96e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 972:	00000717          	auipc	a4,0x0
 976:	16a73f23          	sd	a0,382(a4) # af0 <freep>
      return (void*)(p + 1);
 97a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 97e:	70e2                	ld	ra,56(sp)
 980:	7442                	ld	s0,48(sp)
 982:	74a2                	ld	s1,40(sp)
 984:	7902                	ld	s2,32(sp)
 986:	69e2                	ld	s3,24(sp)
 988:	6a42                	ld	s4,16(sp)
 98a:	6aa2                	ld	s5,8(sp)
 98c:	6b02                	ld	s6,0(sp)
 98e:	6121                	addi	sp,sp,64
 990:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 992:	6398                	ld	a4,0(a5)
 994:	e118                	sd	a4,0(a0)
 996:	bff1                	j	972 <malloc+0x88>
  hp->s.size = nu;
 998:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 99c:	0541                	addi	a0,a0,16
 99e:	00000097          	auipc	ra,0x0
 9a2:	eca080e7          	jalr	-310(ra) # 868 <free>
  return freep;
 9a6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9aa:	d971                	beqz	a0,97e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ac:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ae:	4798                	lw	a4,8(a5)
 9b0:	fa9775e3          	bgeu	a4,s1,95a <malloc+0x70>
    if(p == freep)
 9b4:	00093703          	ld	a4,0(s2)
 9b8:	853e                	mv	a0,a5
 9ba:	fef719e3          	bne	a4,a5,9ac <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 9be:	8552                	mv	a0,s4
 9c0:	00000097          	auipc	ra,0x0
 9c4:	b80080e7          	jalr	-1152(ra) # 540 <sbrk>
  if(p == (char*)-1)
 9c8:	fd5518e3          	bne	a0,s5,998 <malloc+0xae>
        return 0;
 9cc:	4501                	li	a0,0
 9ce:	bf45                	j	97e <malloc+0x94>
