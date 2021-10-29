
user/_xargs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/param.h"

#define MAXN 1024

int main(int argc, char *argv[])
{
   0:	a9010113          	addi	sp,sp,-1392
   4:	56113423          	sd	ra,1384(sp)
   8:	56813023          	sd	s0,1376(sp)
   c:	54913c23          	sd	s1,1368(sp)
  10:	55213823          	sd	s2,1360(sp)
  14:	55313423          	sd	s3,1352(sp)
  18:	55413023          	sd	s4,1344(sp)
  1c:	53513c23          	sd	s5,1336(sp)
  20:	53613823          	sd	s6,1328(sp)
  24:	53713423          	sd	s7,1320(sp)
  28:	53813023          	sd	s8,1312(sp)
  2c:	51913c23          	sd	s9,1304(sp)
  30:	51a13823          	sd	s10,1296(sp)
  34:	57010413          	addi	s0,sp,1392
    if (argc < 2)
  38:	4785                	li	a5,1
  3a:	04a7d463          	bge	a5,a0,82 <main+0x82>
  3e:	00858713          	addi	a4,a1,8
  42:	ea040793          	addi	a5,s0,-352
  46:	ffe5061b          	addiw	a2,a0,-2
  4a:	02061693          	slli	a3,a2,0x20
  4e:	01d6d613          	srli	a2,a3,0x1d
  52:	ea840693          	addi	a3,s0,-344
  56:	9636                	add	a2,a2,a3
        exit(1);
    }

    char *_argv[MAXARG];    // 存放子进程exec的参数
    for (int i = 1; i < argc; i++)  // 略去xargs
        _argv[i - 1] = argv[i];
  58:	6314                	ld	a3,0(a4)
  5a:	e394                	sd	a3,0(a5)
    for (int i = 1; i < argc; i++)  // 略去xargs
  5c:	0721                	addi	a4,a4,8
  5e:	07a1                	addi	a5,a5,8
  60:	fec79ce3          	bne	a5,a2,58 <main+0x58>
    char buf[MAXN]; // 存放从标准输入转化而来的参数
    char c = 0;
  64:	a8040fa3          	sb	zero,-1377(s0)

    while (stat) // 标准输入中还有数据
    {
        int buf_cnt = 0;    // buf尾指针
        int arg_begin = 0;  // 当前这个参数在buf中开始的位置
        int argv_cnt = argc - 1;
  68:	fff50d1b          	addiw	s10,a0,-1
  6c:	4b05                	li	s6,1
        int arg_begin = 0;  // 当前这个参数在buf中开始的位置
  6e:	4a81                	li	s5,0
        while (1)   // 读取一行
        {
            stat = read(0, &c, 1);
            if (stat == 0) // 标准输入中没有数据，exit
                exit(0);
            if (c == ' ' || c == '\n')
  70:	02000c13          	li	s8,32
        int argv_cnt = argc - 1;
  74:	8a6a                	mv	s4,s10
  76:	aa040913          	addi	s2,s0,-1376
  7a:	84da                	mv	s1,s6
        int arg_begin = 0;  // 当前这个参数在buf中开始的位置
  7c:	89d6                	mv	s3,s5
            if (c == ' ' || c == '\n')
  7e:	4ca9                	li	s9,10
  80:	a8a1                	j	d8 <main+0xd8>
        fprintf(2, "usage: xargs command\n");
  82:	00001597          	auipc	a1,0x1
  86:	84e58593          	addi	a1,a1,-1970 # 8d0 <malloc+0xec>
  8a:	4509                	li	a0,2
  8c:	00000097          	auipc	ra,0x0
  90:	672080e7          	jalr	1650(ra) # 6fe <fprintf>
        exit(1);
  94:	4505                	li	a0,1
  96:	00000097          	auipc	ra,0x0
  9a:	31c080e7          	jalr	796(ra) # 3b2 <exit>
                exit(0);
  9e:	00000097          	auipc	ra,0x0
  a2:	314080e7          	jalr	788(ra) # 3b2 <exit>
        }

        _argv[argv_cnt] = 0;
        if (fork() == 0)
        {
            exec(_argv[0], _argv);
  a6:	ea040593          	addi	a1,s0,-352
  aa:	ea043503          	ld	a0,-352(s0)
  ae:	00000097          	auipc	ra,0x0
  b2:	33c080e7          	jalr	828(ra) # 3ea <exec>
  b6:	bf7d                	j	74 <main+0x74>
                buf[buf_cnt++] = 0;
  b8:	00090023          	sb	zero,0(s2)
                _argv[argv_cnt++] = &buf[arg_begin];
  bc:	003a1793          	slli	a5,s4,0x3
  c0:	fa078793          	addi	a5,a5,-96
  c4:	97a2                	add	a5,a5,s0
  c6:	aa040713          	addi	a4,s0,-1376
  ca:	99ba                	add	s3,s3,a4
  cc:	f137b023          	sd	s3,-256(a5)
  d0:	2a05                	addiw	s4,s4,1
                buf[buf_cnt++] = 0;
  d2:	89a6                	mv	s3,s1
  d4:	2485                	addiw	s1,s1,1
  d6:	0905                	addi	s2,s2,1
  d8:	fff48b9b          	addiw	s7,s1,-1
            stat = read(0, &c, 1);
  dc:	865a                	mv	a2,s6
  de:	a9f40593          	addi	a1,s0,-1377
  e2:	8556                	mv	a0,s5
  e4:	00000097          	auipc	ra,0x0
  e8:	2e6080e7          	jalr	742(ra) # 3ca <read>
            if (stat == 0) // 标准输入中没有数据，exit
  ec:	d94d                	beqz	a0,9e <main+0x9e>
            if (c == ' ' || c == '\n')
  ee:	a9f44783          	lbu	a5,-1377(s0)
  f2:	fd8783e3          	beq	a5,s8,b8 <main+0xb8>
  f6:	01978563          	beq	a5,s9,100 <main+0x100>
                buf[buf_cnt++] = c;
  fa:	00f90023          	sb	a5,0(s2)
  fe:	bfd9                	j	d4 <main+0xd4>
                buf[buf_cnt++] = 0;
 100:	fa0b8793          	addi	a5,s7,-96
 104:	00878bb3          	add	s7,a5,s0
 108:	b00b8023          	sb	zero,-1280(s7)
                _argv[argv_cnt++] = &buf[arg_begin];
 10c:	003a1793          	slli	a5,s4,0x3
 110:	fa078793          	addi	a5,a5,-96
 114:	97a2                	add	a5,a5,s0
 116:	aa040713          	addi	a4,s0,-1376
 11a:	99ba                	add	s3,s3,a4
 11c:	f137b023          	sd	s3,-256(a5)
        _argv[argv_cnt] = 0;
 120:	001a079b          	addiw	a5,s4,1
 124:	078e                	slli	a5,a5,0x3
 126:	fa078793          	addi	a5,a5,-96
 12a:	97a2                	add	a5,a5,s0
 12c:	f007b023          	sd	zero,-256(a5)
        if (fork() == 0)
 130:	00000097          	auipc	ra,0x0
 134:	27a080e7          	jalr	634(ra) # 3aa <fork>
 138:	d53d                	beqz	a0,a6 <main+0xa6>
        }
        else
        {
            wait(0);
 13a:	8556                	mv	a0,s5
 13c:	00000097          	auipc	ra,0x0
 140:	27e080e7          	jalr	638(ra) # 3ba <wait>
    while (stat) // 标准输入中还有数据
 144:	bf05                	j	74 <main+0x74>

0000000000000146 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 146:	1141                	addi	sp,sp,-16
 148:	e422                	sd	s0,8(sp)
 14a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 14c:	87aa                	mv	a5,a0
 14e:	0585                	addi	a1,a1,1
 150:	0785                	addi	a5,a5,1
 152:	fff5c703          	lbu	a4,-1(a1)
 156:	fee78fa3          	sb	a4,-1(a5)
 15a:	fb75                	bnez	a4,14e <strcpy+0x8>
    ;
  return os;
}
 15c:	6422                	ld	s0,8(sp)
 15e:	0141                	addi	sp,sp,16
 160:	8082                	ret

0000000000000162 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 162:	1141                	addi	sp,sp,-16
 164:	e422                	sd	s0,8(sp)
 166:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 168:	00054783          	lbu	a5,0(a0)
 16c:	cb91                	beqz	a5,180 <strcmp+0x1e>
 16e:	0005c703          	lbu	a4,0(a1)
 172:	00f71763          	bne	a4,a5,180 <strcmp+0x1e>
    p++, q++;
 176:	0505                	addi	a0,a0,1
 178:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 17a:	00054783          	lbu	a5,0(a0)
 17e:	fbe5                	bnez	a5,16e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 180:	0005c503          	lbu	a0,0(a1)
}
 184:	40a7853b          	subw	a0,a5,a0
 188:	6422                	ld	s0,8(sp)
 18a:	0141                	addi	sp,sp,16
 18c:	8082                	ret

000000000000018e <strlen>:

uint
strlen(const char *s)
{
 18e:	1141                	addi	sp,sp,-16
 190:	e422                	sd	s0,8(sp)
 192:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 194:	00054783          	lbu	a5,0(a0)
 198:	cf91                	beqz	a5,1b4 <strlen+0x26>
 19a:	0505                	addi	a0,a0,1
 19c:	87aa                	mv	a5,a0
 19e:	4685                	li	a3,1
 1a0:	9e89                	subw	a3,a3,a0
 1a2:	00f6853b          	addw	a0,a3,a5
 1a6:	0785                	addi	a5,a5,1
 1a8:	fff7c703          	lbu	a4,-1(a5)
 1ac:	fb7d                	bnez	a4,1a2 <strlen+0x14>
    ;
  return n;
}
 1ae:	6422                	ld	s0,8(sp)
 1b0:	0141                	addi	sp,sp,16
 1b2:	8082                	ret
  for(n = 0; s[n]; n++)
 1b4:	4501                	li	a0,0
 1b6:	bfe5                	j	1ae <strlen+0x20>

00000000000001b8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b8:	1141                	addi	sp,sp,-16
 1ba:	e422                	sd	s0,8(sp)
 1bc:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1be:	ca19                	beqz	a2,1d4 <memset+0x1c>
 1c0:	87aa                	mv	a5,a0
 1c2:	1602                	slli	a2,a2,0x20
 1c4:	9201                	srli	a2,a2,0x20
 1c6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1ca:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ce:	0785                	addi	a5,a5,1
 1d0:	fee79de3          	bne	a5,a4,1ca <memset+0x12>
  }
  return dst;
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	addi	sp,sp,16
 1d8:	8082                	ret

00000000000001da <strchr>:

char*
strchr(const char *s, char c)
{
 1da:	1141                	addi	sp,sp,-16
 1dc:	e422                	sd	s0,8(sp)
 1de:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1e0:	00054783          	lbu	a5,0(a0)
 1e4:	cb99                	beqz	a5,1fa <strchr+0x20>
    if(*s == c)
 1e6:	00f58763          	beq	a1,a5,1f4 <strchr+0x1a>
  for(; *s; s++)
 1ea:	0505                	addi	a0,a0,1
 1ec:	00054783          	lbu	a5,0(a0)
 1f0:	fbfd                	bnez	a5,1e6 <strchr+0xc>
      return (char*)s;
  return 0;
 1f2:	4501                	li	a0,0
}
 1f4:	6422                	ld	s0,8(sp)
 1f6:	0141                	addi	sp,sp,16
 1f8:	8082                	ret
  return 0;
 1fa:	4501                	li	a0,0
 1fc:	bfe5                	j	1f4 <strchr+0x1a>

00000000000001fe <gets>:

char*
gets(char *buf, int max)
{
 1fe:	711d                	addi	sp,sp,-96
 200:	ec86                	sd	ra,88(sp)
 202:	e8a2                	sd	s0,80(sp)
 204:	e4a6                	sd	s1,72(sp)
 206:	e0ca                	sd	s2,64(sp)
 208:	fc4e                	sd	s3,56(sp)
 20a:	f852                	sd	s4,48(sp)
 20c:	f456                	sd	s5,40(sp)
 20e:	f05a                	sd	s6,32(sp)
 210:	ec5e                	sd	s7,24(sp)
 212:	1080                	addi	s0,sp,96
 214:	8baa                	mv	s7,a0
 216:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 218:	892a                	mv	s2,a0
 21a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 21c:	4aa9                	li	s5,10
 21e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 220:	89a6                	mv	s3,s1
 222:	2485                	addiw	s1,s1,1
 224:	0344d863          	bge	s1,s4,254 <gets+0x56>
    cc = read(0, &c, 1);
 228:	4605                	li	a2,1
 22a:	faf40593          	addi	a1,s0,-81
 22e:	4501                	li	a0,0
 230:	00000097          	auipc	ra,0x0
 234:	19a080e7          	jalr	410(ra) # 3ca <read>
    if(cc < 1)
 238:	00a05e63          	blez	a0,254 <gets+0x56>
    buf[i++] = c;
 23c:	faf44783          	lbu	a5,-81(s0)
 240:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 244:	01578763          	beq	a5,s5,252 <gets+0x54>
 248:	0905                	addi	s2,s2,1
 24a:	fd679be3          	bne	a5,s6,220 <gets+0x22>
  for(i=0; i+1 < max; ){
 24e:	89a6                	mv	s3,s1
 250:	a011                	j	254 <gets+0x56>
 252:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 254:	99de                	add	s3,s3,s7
 256:	00098023          	sb	zero,0(s3)
  return buf;
}
 25a:	855e                	mv	a0,s7
 25c:	60e6                	ld	ra,88(sp)
 25e:	6446                	ld	s0,80(sp)
 260:	64a6                	ld	s1,72(sp)
 262:	6906                	ld	s2,64(sp)
 264:	79e2                	ld	s3,56(sp)
 266:	7a42                	ld	s4,48(sp)
 268:	7aa2                	ld	s5,40(sp)
 26a:	7b02                	ld	s6,32(sp)
 26c:	6be2                	ld	s7,24(sp)
 26e:	6125                	addi	sp,sp,96
 270:	8082                	ret

0000000000000272 <stat>:

int
stat(const char *n, struct stat *st)
{
 272:	1101                	addi	sp,sp,-32
 274:	ec06                	sd	ra,24(sp)
 276:	e822                	sd	s0,16(sp)
 278:	e426                	sd	s1,8(sp)
 27a:	e04a                	sd	s2,0(sp)
 27c:	1000                	addi	s0,sp,32
 27e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 280:	4581                	li	a1,0
 282:	00000097          	auipc	ra,0x0
 286:	170080e7          	jalr	368(ra) # 3f2 <open>
  if(fd < 0)
 28a:	02054563          	bltz	a0,2b4 <stat+0x42>
 28e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 290:	85ca                	mv	a1,s2
 292:	00000097          	auipc	ra,0x0
 296:	178080e7          	jalr	376(ra) # 40a <fstat>
 29a:	892a                	mv	s2,a0
  close(fd);
 29c:	8526                	mv	a0,s1
 29e:	00000097          	auipc	ra,0x0
 2a2:	13c080e7          	jalr	316(ra) # 3da <close>
  return r;
}
 2a6:	854a                	mv	a0,s2
 2a8:	60e2                	ld	ra,24(sp)
 2aa:	6442                	ld	s0,16(sp)
 2ac:	64a2                	ld	s1,8(sp)
 2ae:	6902                	ld	s2,0(sp)
 2b0:	6105                	addi	sp,sp,32
 2b2:	8082                	ret
    return -1;
 2b4:	597d                	li	s2,-1
 2b6:	bfc5                	j	2a6 <stat+0x34>

00000000000002b8 <atoi>:

int
atoi(const char *s)
{
 2b8:	1141                	addi	sp,sp,-16
 2ba:	e422                	sd	s0,8(sp)
 2bc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2be:	00054683          	lbu	a3,0(a0)
 2c2:	fd06879b          	addiw	a5,a3,-48
 2c6:	0ff7f793          	zext.b	a5,a5
 2ca:	4625                	li	a2,9
 2cc:	02f66863          	bltu	a2,a5,2fc <atoi+0x44>
 2d0:	872a                	mv	a4,a0
  n = 0;
 2d2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2d4:	0705                	addi	a4,a4,1
 2d6:	0025179b          	slliw	a5,a0,0x2
 2da:	9fa9                	addw	a5,a5,a0
 2dc:	0017979b          	slliw	a5,a5,0x1
 2e0:	9fb5                	addw	a5,a5,a3
 2e2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2e6:	00074683          	lbu	a3,0(a4)
 2ea:	fd06879b          	addiw	a5,a3,-48
 2ee:	0ff7f793          	zext.b	a5,a5
 2f2:	fef671e3          	bgeu	a2,a5,2d4 <atoi+0x1c>
  return n;
}
 2f6:	6422                	ld	s0,8(sp)
 2f8:	0141                	addi	sp,sp,16
 2fa:	8082                	ret
  n = 0;
 2fc:	4501                	li	a0,0
 2fe:	bfe5                	j	2f6 <atoi+0x3e>

0000000000000300 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 300:	1141                	addi	sp,sp,-16
 302:	e422                	sd	s0,8(sp)
 304:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 306:	02b57463          	bgeu	a0,a1,32e <memmove+0x2e>
    while(n-- > 0)
 30a:	00c05f63          	blez	a2,328 <memmove+0x28>
 30e:	1602                	slli	a2,a2,0x20
 310:	9201                	srli	a2,a2,0x20
 312:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 316:	872a                	mv	a4,a0
      *dst++ = *src++;
 318:	0585                	addi	a1,a1,1
 31a:	0705                	addi	a4,a4,1
 31c:	fff5c683          	lbu	a3,-1(a1)
 320:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 324:	fee79ae3          	bne	a5,a4,318 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 328:	6422                	ld	s0,8(sp)
 32a:	0141                	addi	sp,sp,16
 32c:	8082                	ret
    dst += n;
 32e:	00c50733          	add	a4,a0,a2
    src += n;
 332:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 334:	fec05ae3          	blez	a2,328 <memmove+0x28>
 338:	fff6079b          	addiw	a5,a2,-1
 33c:	1782                	slli	a5,a5,0x20
 33e:	9381                	srli	a5,a5,0x20
 340:	fff7c793          	not	a5,a5
 344:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 346:	15fd                	addi	a1,a1,-1
 348:	177d                	addi	a4,a4,-1
 34a:	0005c683          	lbu	a3,0(a1)
 34e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 352:	fee79ae3          	bne	a5,a4,346 <memmove+0x46>
 356:	bfc9                	j	328 <memmove+0x28>

0000000000000358 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 358:	1141                	addi	sp,sp,-16
 35a:	e422                	sd	s0,8(sp)
 35c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 35e:	ca05                	beqz	a2,38e <memcmp+0x36>
 360:	fff6069b          	addiw	a3,a2,-1
 364:	1682                	slli	a3,a3,0x20
 366:	9281                	srli	a3,a3,0x20
 368:	0685                	addi	a3,a3,1
 36a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 36c:	00054783          	lbu	a5,0(a0)
 370:	0005c703          	lbu	a4,0(a1)
 374:	00e79863          	bne	a5,a4,384 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 378:	0505                	addi	a0,a0,1
    p2++;
 37a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 37c:	fed518e3          	bne	a0,a3,36c <memcmp+0x14>
  }
  return 0;
 380:	4501                	li	a0,0
 382:	a019                	j	388 <memcmp+0x30>
      return *p1 - *p2;
 384:	40e7853b          	subw	a0,a5,a4
}
 388:	6422                	ld	s0,8(sp)
 38a:	0141                	addi	sp,sp,16
 38c:	8082                	ret
  return 0;
 38e:	4501                	li	a0,0
 390:	bfe5                	j	388 <memcmp+0x30>

0000000000000392 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 392:	1141                	addi	sp,sp,-16
 394:	e406                	sd	ra,8(sp)
 396:	e022                	sd	s0,0(sp)
 398:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 39a:	00000097          	auipc	ra,0x0
 39e:	f66080e7          	jalr	-154(ra) # 300 <memmove>
}
 3a2:	60a2                	ld	ra,8(sp)
 3a4:	6402                	ld	s0,0(sp)
 3a6:	0141                	addi	sp,sp,16
 3a8:	8082                	ret

00000000000003aa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3aa:	4885                	li	a7,1
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3b2:	4889                	li	a7,2
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <wait>:
.global wait
wait:
 li a7, SYS_wait
 3ba:	488d                	li	a7,3
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3c2:	4891                	li	a7,4
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <read>:
.global read
read:
 li a7, SYS_read
 3ca:	4895                	li	a7,5
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <write>:
.global write
write:
 li a7, SYS_write
 3d2:	48c1                	li	a7,16
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <close>:
.global close
close:
 li a7, SYS_close
 3da:	48d5                	li	a7,21
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3e2:	4899                	li	a7,6
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ea:	489d                	li	a7,7
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <open>:
.global open
open:
 li a7, SYS_open
 3f2:	48bd                	li	a7,15
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3fa:	48c5                	li	a7,17
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 402:	48c9                	li	a7,18
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 40a:	48a1                	li	a7,8
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <link>:
.global link
link:
 li a7, SYS_link
 412:	48cd                	li	a7,19
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 41a:	48d1                	li	a7,20
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 422:	48a5                	li	a7,9
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <dup>:
.global dup
dup:
 li a7, SYS_dup
 42a:	48a9                	li	a7,10
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 432:	48ad                	li	a7,11
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 43a:	48b1                	li	a7,12
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 442:	48b5                	li	a7,13
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 44a:	48b9                	li	a7,14
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 452:	1101                	addi	sp,sp,-32
 454:	ec06                	sd	ra,24(sp)
 456:	e822                	sd	s0,16(sp)
 458:	1000                	addi	s0,sp,32
 45a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 45e:	4605                	li	a2,1
 460:	fef40593          	addi	a1,s0,-17
 464:	00000097          	auipc	ra,0x0
 468:	f6e080e7          	jalr	-146(ra) # 3d2 <write>
}
 46c:	60e2                	ld	ra,24(sp)
 46e:	6442                	ld	s0,16(sp)
 470:	6105                	addi	sp,sp,32
 472:	8082                	ret

0000000000000474 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 474:	7139                	addi	sp,sp,-64
 476:	fc06                	sd	ra,56(sp)
 478:	f822                	sd	s0,48(sp)
 47a:	f426                	sd	s1,40(sp)
 47c:	f04a                	sd	s2,32(sp)
 47e:	ec4e                	sd	s3,24(sp)
 480:	0080                	addi	s0,sp,64
 482:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 484:	c299                	beqz	a3,48a <printint+0x16>
 486:	0805c963          	bltz	a1,518 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 48a:	2581                	sext.w	a1,a1
  neg = 0;
 48c:	4881                	li	a7,0
 48e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 492:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 494:	2601                	sext.w	a2,a2
 496:	00000517          	auipc	a0,0x0
 49a:	4b250513          	addi	a0,a0,1202 # 948 <digits>
 49e:	883a                	mv	a6,a4
 4a0:	2705                	addiw	a4,a4,1
 4a2:	02c5f7bb          	remuw	a5,a1,a2
 4a6:	1782                	slli	a5,a5,0x20
 4a8:	9381                	srli	a5,a5,0x20
 4aa:	97aa                	add	a5,a5,a0
 4ac:	0007c783          	lbu	a5,0(a5)
 4b0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4b4:	0005879b          	sext.w	a5,a1
 4b8:	02c5d5bb          	divuw	a1,a1,a2
 4bc:	0685                	addi	a3,a3,1
 4be:	fec7f0e3          	bgeu	a5,a2,49e <printint+0x2a>
  if(neg)
 4c2:	00088c63          	beqz	a7,4da <printint+0x66>
    buf[i++] = '-';
 4c6:	fd070793          	addi	a5,a4,-48
 4ca:	00878733          	add	a4,a5,s0
 4ce:	02d00793          	li	a5,45
 4d2:	fef70823          	sb	a5,-16(a4)
 4d6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4da:	02e05863          	blez	a4,50a <printint+0x96>
 4de:	fc040793          	addi	a5,s0,-64
 4e2:	00e78933          	add	s2,a5,a4
 4e6:	fff78993          	addi	s3,a5,-1
 4ea:	99ba                	add	s3,s3,a4
 4ec:	377d                	addiw	a4,a4,-1
 4ee:	1702                	slli	a4,a4,0x20
 4f0:	9301                	srli	a4,a4,0x20
 4f2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4f6:	fff94583          	lbu	a1,-1(s2)
 4fa:	8526                	mv	a0,s1
 4fc:	00000097          	auipc	ra,0x0
 500:	f56080e7          	jalr	-170(ra) # 452 <putc>
  while(--i >= 0)
 504:	197d                	addi	s2,s2,-1
 506:	ff3918e3          	bne	s2,s3,4f6 <printint+0x82>
}
 50a:	70e2                	ld	ra,56(sp)
 50c:	7442                	ld	s0,48(sp)
 50e:	74a2                	ld	s1,40(sp)
 510:	7902                	ld	s2,32(sp)
 512:	69e2                	ld	s3,24(sp)
 514:	6121                	addi	sp,sp,64
 516:	8082                	ret
    x = -xx;
 518:	40b005bb          	negw	a1,a1
    neg = 1;
 51c:	4885                	li	a7,1
    x = -xx;
 51e:	bf85                	j	48e <printint+0x1a>

0000000000000520 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 520:	7119                	addi	sp,sp,-128
 522:	fc86                	sd	ra,120(sp)
 524:	f8a2                	sd	s0,112(sp)
 526:	f4a6                	sd	s1,104(sp)
 528:	f0ca                	sd	s2,96(sp)
 52a:	ecce                	sd	s3,88(sp)
 52c:	e8d2                	sd	s4,80(sp)
 52e:	e4d6                	sd	s5,72(sp)
 530:	e0da                	sd	s6,64(sp)
 532:	fc5e                	sd	s7,56(sp)
 534:	f862                	sd	s8,48(sp)
 536:	f466                	sd	s9,40(sp)
 538:	f06a                	sd	s10,32(sp)
 53a:	ec6e                	sd	s11,24(sp)
 53c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 53e:	0005c903          	lbu	s2,0(a1)
 542:	18090f63          	beqz	s2,6e0 <vprintf+0x1c0>
 546:	8aaa                	mv	s5,a0
 548:	8b32                	mv	s6,a2
 54a:	00158493          	addi	s1,a1,1
  state = 0;
 54e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 550:	02500a13          	li	s4,37
 554:	4c55                	li	s8,21
 556:	00000c97          	auipc	s9,0x0
 55a:	39ac8c93          	addi	s9,s9,922 # 8f0 <malloc+0x10c>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 55e:	02800d93          	li	s11,40
  putc(fd, 'x');
 562:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 564:	00000b97          	auipc	s7,0x0
 568:	3e4b8b93          	addi	s7,s7,996 # 948 <digits>
 56c:	a839                	j	58a <vprintf+0x6a>
        putc(fd, c);
 56e:	85ca                	mv	a1,s2
 570:	8556                	mv	a0,s5
 572:	00000097          	auipc	ra,0x0
 576:	ee0080e7          	jalr	-288(ra) # 452 <putc>
 57a:	a019                	j	580 <vprintf+0x60>
    } else if(state == '%'){
 57c:	01498d63          	beq	s3,s4,596 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 580:	0485                	addi	s1,s1,1
 582:	fff4c903          	lbu	s2,-1(s1)
 586:	14090d63          	beqz	s2,6e0 <vprintf+0x1c0>
    if(state == 0){
 58a:	fe0999e3          	bnez	s3,57c <vprintf+0x5c>
      if(c == '%'){
 58e:	ff4910e3          	bne	s2,s4,56e <vprintf+0x4e>
        state = '%';
 592:	89d2                	mv	s3,s4
 594:	b7f5                	j	580 <vprintf+0x60>
      if(c == 'd'){
 596:	11490c63          	beq	s2,s4,6ae <vprintf+0x18e>
 59a:	f9d9079b          	addiw	a5,s2,-99
 59e:	0ff7f793          	zext.b	a5,a5
 5a2:	10fc6e63          	bltu	s8,a5,6be <vprintf+0x19e>
 5a6:	f9d9079b          	addiw	a5,s2,-99
 5aa:	0ff7f713          	zext.b	a4,a5
 5ae:	10ec6863          	bltu	s8,a4,6be <vprintf+0x19e>
 5b2:	00271793          	slli	a5,a4,0x2
 5b6:	97e6                	add	a5,a5,s9
 5b8:	439c                	lw	a5,0(a5)
 5ba:	97e6                	add	a5,a5,s9
 5bc:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5be:	008b0913          	addi	s2,s6,8
 5c2:	4685                	li	a3,1
 5c4:	4629                	li	a2,10
 5c6:	000b2583          	lw	a1,0(s6)
 5ca:	8556                	mv	a0,s5
 5cc:	00000097          	auipc	ra,0x0
 5d0:	ea8080e7          	jalr	-344(ra) # 474 <printint>
 5d4:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5d6:	4981                	li	s3,0
 5d8:	b765                	j	580 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5da:	008b0913          	addi	s2,s6,8
 5de:	4681                	li	a3,0
 5e0:	4629                	li	a2,10
 5e2:	000b2583          	lw	a1,0(s6)
 5e6:	8556                	mv	a0,s5
 5e8:	00000097          	auipc	ra,0x0
 5ec:	e8c080e7          	jalr	-372(ra) # 474 <printint>
 5f0:	8b4a                	mv	s6,s2
      state = 0;
 5f2:	4981                	li	s3,0
 5f4:	b771                	j	580 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5f6:	008b0913          	addi	s2,s6,8
 5fa:	4681                	li	a3,0
 5fc:	866a                	mv	a2,s10
 5fe:	000b2583          	lw	a1,0(s6)
 602:	8556                	mv	a0,s5
 604:	00000097          	auipc	ra,0x0
 608:	e70080e7          	jalr	-400(ra) # 474 <printint>
 60c:	8b4a                	mv	s6,s2
      state = 0;
 60e:	4981                	li	s3,0
 610:	bf85                	j	580 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 612:	008b0793          	addi	a5,s6,8
 616:	f8f43423          	sd	a5,-120(s0)
 61a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 61e:	03000593          	li	a1,48
 622:	8556                	mv	a0,s5
 624:	00000097          	auipc	ra,0x0
 628:	e2e080e7          	jalr	-466(ra) # 452 <putc>
  putc(fd, 'x');
 62c:	07800593          	li	a1,120
 630:	8556                	mv	a0,s5
 632:	00000097          	auipc	ra,0x0
 636:	e20080e7          	jalr	-480(ra) # 452 <putc>
 63a:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 63c:	03c9d793          	srli	a5,s3,0x3c
 640:	97de                	add	a5,a5,s7
 642:	0007c583          	lbu	a1,0(a5)
 646:	8556                	mv	a0,s5
 648:	00000097          	auipc	ra,0x0
 64c:	e0a080e7          	jalr	-502(ra) # 452 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 650:	0992                	slli	s3,s3,0x4
 652:	397d                	addiw	s2,s2,-1
 654:	fe0914e3          	bnez	s2,63c <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 658:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 65c:	4981                	li	s3,0
 65e:	b70d                	j	580 <vprintf+0x60>
        s = va_arg(ap, char*);
 660:	008b0913          	addi	s2,s6,8
 664:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 668:	02098163          	beqz	s3,68a <vprintf+0x16a>
        while(*s != 0){
 66c:	0009c583          	lbu	a1,0(s3)
 670:	c5ad                	beqz	a1,6da <vprintf+0x1ba>
          putc(fd, *s);
 672:	8556                	mv	a0,s5
 674:	00000097          	auipc	ra,0x0
 678:	dde080e7          	jalr	-546(ra) # 452 <putc>
          s++;
 67c:	0985                	addi	s3,s3,1
        while(*s != 0){
 67e:	0009c583          	lbu	a1,0(s3)
 682:	f9e5                	bnez	a1,672 <vprintf+0x152>
        s = va_arg(ap, char*);
 684:	8b4a                	mv	s6,s2
      state = 0;
 686:	4981                	li	s3,0
 688:	bde5                	j	580 <vprintf+0x60>
          s = "(null)";
 68a:	00000997          	auipc	s3,0x0
 68e:	25e98993          	addi	s3,s3,606 # 8e8 <malloc+0x104>
        while(*s != 0){
 692:	85ee                	mv	a1,s11
 694:	bff9                	j	672 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 696:	008b0913          	addi	s2,s6,8
 69a:	000b4583          	lbu	a1,0(s6)
 69e:	8556                	mv	a0,s5
 6a0:	00000097          	auipc	ra,0x0
 6a4:	db2080e7          	jalr	-590(ra) # 452 <putc>
 6a8:	8b4a                	mv	s6,s2
      state = 0;
 6aa:	4981                	li	s3,0
 6ac:	bdd1                	j	580 <vprintf+0x60>
        putc(fd, c);
 6ae:	85d2                	mv	a1,s4
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	da0080e7          	jalr	-608(ra) # 452 <putc>
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	b5d1                	j	580 <vprintf+0x60>
        putc(fd, '%');
 6be:	85d2                	mv	a1,s4
 6c0:	8556                	mv	a0,s5
 6c2:	00000097          	auipc	ra,0x0
 6c6:	d90080e7          	jalr	-624(ra) # 452 <putc>
        putc(fd, c);
 6ca:	85ca                	mv	a1,s2
 6cc:	8556                	mv	a0,s5
 6ce:	00000097          	auipc	ra,0x0
 6d2:	d84080e7          	jalr	-636(ra) # 452 <putc>
      state = 0;
 6d6:	4981                	li	s3,0
 6d8:	b565                	j	580 <vprintf+0x60>
        s = va_arg(ap, char*);
 6da:	8b4a                	mv	s6,s2
      state = 0;
 6dc:	4981                	li	s3,0
 6de:	b54d                	j	580 <vprintf+0x60>
    }
  }
}
 6e0:	70e6                	ld	ra,120(sp)
 6e2:	7446                	ld	s0,112(sp)
 6e4:	74a6                	ld	s1,104(sp)
 6e6:	7906                	ld	s2,96(sp)
 6e8:	69e6                	ld	s3,88(sp)
 6ea:	6a46                	ld	s4,80(sp)
 6ec:	6aa6                	ld	s5,72(sp)
 6ee:	6b06                	ld	s6,64(sp)
 6f0:	7be2                	ld	s7,56(sp)
 6f2:	7c42                	ld	s8,48(sp)
 6f4:	7ca2                	ld	s9,40(sp)
 6f6:	7d02                	ld	s10,32(sp)
 6f8:	6de2                	ld	s11,24(sp)
 6fa:	6109                	addi	sp,sp,128
 6fc:	8082                	ret

00000000000006fe <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6fe:	715d                	addi	sp,sp,-80
 700:	ec06                	sd	ra,24(sp)
 702:	e822                	sd	s0,16(sp)
 704:	1000                	addi	s0,sp,32
 706:	e010                	sd	a2,0(s0)
 708:	e414                	sd	a3,8(s0)
 70a:	e818                	sd	a4,16(s0)
 70c:	ec1c                	sd	a5,24(s0)
 70e:	03043023          	sd	a6,32(s0)
 712:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 716:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 71a:	8622                	mv	a2,s0
 71c:	00000097          	auipc	ra,0x0
 720:	e04080e7          	jalr	-508(ra) # 520 <vprintf>
}
 724:	60e2                	ld	ra,24(sp)
 726:	6442                	ld	s0,16(sp)
 728:	6161                	addi	sp,sp,80
 72a:	8082                	ret

000000000000072c <printf>:

void
printf(const char *fmt, ...)
{
 72c:	711d                	addi	sp,sp,-96
 72e:	ec06                	sd	ra,24(sp)
 730:	e822                	sd	s0,16(sp)
 732:	1000                	addi	s0,sp,32
 734:	e40c                	sd	a1,8(s0)
 736:	e810                	sd	a2,16(s0)
 738:	ec14                	sd	a3,24(s0)
 73a:	f018                	sd	a4,32(s0)
 73c:	f41c                	sd	a5,40(s0)
 73e:	03043823          	sd	a6,48(s0)
 742:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 746:	00840613          	addi	a2,s0,8
 74a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 74e:	85aa                	mv	a1,a0
 750:	4505                	li	a0,1
 752:	00000097          	auipc	ra,0x0
 756:	dce080e7          	jalr	-562(ra) # 520 <vprintf>
}
 75a:	60e2                	ld	ra,24(sp)
 75c:	6442                	ld	s0,16(sp)
 75e:	6125                	addi	sp,sp,96
 760:	8082                	ret

0000000000000762 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 762:	1141                	addi	sp,sp,-16
 764:	e422                	sd	s0,8(sp)
 766:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 768:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76c:	00000797          	auipc	a5,0x0
 770:	1f47b783          	ld	a5,500(a5) # 960 <freep>
 774:	a02d                	j	79e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 776:	4618                	lw	a4,8(a2)
 778:	9f2d                	addw	a4,a4,a1
 77a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 77e:	6398                	ld	a4,0(a5)
 780:	6310                	ld	a2,0(a4)
 782:	a83d                	j	7c0 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 784:	ff852703          	lw	a4,-8(a0)
 788:	9f31                	addw	a4,a4,a2
 78a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 78c:	ff053683          	ld	a3,-16(a0)
 790:	a091                	j	7d4 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 792:	6398                	ld	a4,0(a5)
 794:	00e7e463          	bltu	a5,a4,79c <free+0x3a>
 798:	00e6ea63          	bltu	a3,a4,7ac <free+0x4a>
{
 79c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79e:	fed7fae3          	bgeu	a5,a3,792 <free+0x30>
 7a2:	6398                	ld	a4,0(a5)
 7a4:	00e6e463          	bltu	a3,a4,7ac <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a8:	fee7eae3          	bltu	a5,a4,79c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7ac:	ff852583          	lw	a1,-8(a0)
 7b0:	6390                	ld	a2,0(a5)
 7b2:	02059813          	slli	a6,a1,0x20
 7b6:	01c85713          	srli	a4,a6,0x1c
 7ba:	9736                	add	a4,a4,a3
 7bc:	fae60de3          	beq	a2,a4,776 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7c0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7c4:	4790                	lw	a2,8(a5)
 7c6:	02061593          	slli	a1,a2,0x20
 7ca:	01c5d713          	srli	a4,a1,0x1c
 7ce:	973e                	add	a4,a4,a5
 7d0:	fae68ae3          	beq	a3,a4,784 <free+0x22>
    p->s.ptr = bp->s.ptr;
 7d4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7d6:	00000717          	auipc	a4,0x0
 7da:	18f73523          	sd	a5,394(a4) # 960 <freep>
}
 7de:	6422                	ld	s0,8(sp)
 7e0:	0141                	addi	sp,sp,16
 7e2:	8082                	ret

00000000000007e4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e4:	7139                	addi	sp,sp,-64
 7e6:	fc06                	sd	ra,56(sp)
 7e8:	f822                	sd	s0,48(sp)
 7ea:	f426                	sd	s1,40(sp)
 7ec:	f04a                	sd	s2,32(sp)
 7ee:	ec4e                	sd	s3,24(sp)
 7f0:	e852                	sd	s4,16(sp)
 7f2:	e456                	sd	s5,8(sp)
 7f4:	e05a                	sd	s6,0(sp)
 7f6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f8:	02051493          	slli	s1,a0,0x20
 7fc:	9081                	srli	s1,s1,0x20
 7fe:	04bd                	addi	s1,s1,15
 800:	8091                	srli	s1,s1,0x4
 802:	0014899b          	addiw	s3,s1,1
 806:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 808:	00000517          	auipc	a0,0x0
 80c:	15853503          	ld	a0,344(a0) # 960 <freep>
 810:	c515                	beqz	a0,83c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 812:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 814:	4798                	lw	a4,8(a5)
 816:	02977f63          	bgeu	a4,s1,854 <malloc+0x70>
 81a:	8a4e                	mv	s4,s3
 81c:	0009871b          	sext.w	a4,s3
 820:	6685                	lui	a3,0x1
 822:	00d77363          	bgeu	a4,a3,828 <malloc+0x44>
 826:	6a05                	lui	s4,0x1
 828:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 82c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 830:	00000917          	auipc	s2,0x0
 834:	13090913          	addi	s2,s2,304 # 960 <freep>
  if(p == (char*)-1)
 838:	5afd                	li	s5,-1
 83a:	a895                	j	8ae <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 83c:	00000797          	auipc	a5,0x0
 840:	12c78793          	addi	a5,a5,300 # 968 <base>
 844:	00000717          	auipc	a4,0x0
 848:	10f73e23          	sd	a5,284(a4) # 960 <freep>
 84c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 84e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 852:	b7e1                	j	81a <malloc+0x36>
      if(p->s.size == nunits)
 854:	02e48c63          	beq	s1,a4,88c <malloc+0xa8>
        p->s.size -= nunits;
 858:	4137073b          	subw	a4,a4,s3
 85c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 85e:	02071693          	slli	a3,a4,0x20
 862:	01c6d713          	srli	a4,a3,0x1c
 866:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 868:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 86c:	00000717          	auipc	a4,0x0
 870:	0ea73a23          	sd	a0,244(a4) # 960 <freep>
      return (void*)(p + 1);
 874:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 878:	70e2                	ld	ra,56(sp)
 87a:	7442                	ld	s0,48(sp)
 87c:	74a2                	ld	s1,40(sp)
 87e:	7902                	ld	s2,32(sp)
 880:	69e2                	ld	s3,24(sp)
 882:	6a42                	ld	s4,16(sp)
 884:	6aa2                	ld	s5,8(sp)
 886:	6b02                	ld	s6,0(sp)
 888:	6121                	addi	sp,sp,64
 88a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 88c:	6398                	ld	a4,0(a5)
 88e:	e118                	sd	a4,0(a0)
 890:	bff1                	j	86c <malloc+0x88>
  hp->s.size = nu;
 892:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 896:	0541                	addi	a0,a0,16
 898:	00000097          	auipc	ra,0x0
 89c:	eca080e7          	jalr	-310(ra) # 762 <free>
  return freep;
 8a0:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8a4:	d971                	beqz	a0,878 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8a8:	4798                	lw	a4,8(a5)
 8aa:	fa9775e3          	bgeu	a4,s1,854 <malloc+0x70>
    if(p == freep)
 8ae:	00093703          	ld	a4,0(s2)
 8b2:	853e                	mv	a0,a5
 8b4:	fef719e3          	bne	a4,a5,8a6 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8b8:	8552                	mv	a0,s4
 8ba:	00000097          	auipc	ra,0x0
 8be:	b80080e7          	jalr	-1152(ra) # 43a <sbrk>
  if(p == (char*)-1)
 8c2:	fd5518e3          	bne	a0,s5,892 <malloc+0xae>
        return 0;
 8c6:	4501                	li	a0,0
 8c8:	bf45                	j	878 <malloc+0x94>
