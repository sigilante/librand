  ::
::::  Random list library
::
::
/+  seq
|%
::    +shuffle: (list T) -> (list T)
::
::  Reorder the elements of a list randomly using the Fisher-Yates algorithm.
::    Examples
::      > (shuffle ~[1 2 3 4 5] eny)
::      ~[3 1 5 2 4]
::      > (shuffle ~[1 2 3 4 5 6 7 8 9] eny)
::      ~[5 2 9 1 8 4 3 7 6]
::  Source
++  shuffle
  |*  [a=(list) eny=@uvJ]
  ^-  (list _?>(?=(^ a) i.a))
  =/  rng  ~(. og eny)
  =/  i  0
  =/  n  (length:seq a)
  |-
  ?:  =(n i)  a
  =^  r1  rng  (rads:rng n)
  =^  r2  rng  (rads:rng n)
  =/  i1  (snag r1 a)
  =/  i2  (snag r2 a)
  =.  a  (snap a i1 i2)
  =.  a  (snap a i2 i1)
  $(i +(i))


++  sample  !!

++  draw  !!

++  draw-with-replacement  !!

::
::  Distributions
::
++  uniform  !!
++  normal   !!
--
