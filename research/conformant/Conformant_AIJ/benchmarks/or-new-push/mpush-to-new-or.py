#! /usr/bin/env python
# -*- coding: latin-1 -*-

#  Copyright (C) 2006 Universitat Pompeu Fabra
#
#  Permission is hereby granted to distribute this software for
#  non-commercial research purposes, provided that this copyright
#  notice is included with any such distribution.
#
#  THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,
#  EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#  PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE
#  SOFTWARE IS WITH YOU.  SHOULD THE PROGRAM PROVE DEFECTIVE, YOU
#  ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
#
# Elaborated by Hector Palacios, hector.palacios@upf.edu, hectorpal@gmail.com
# Joint work with Hector Geffner.

import sys
import os

name = "or-push-new"
if len(sys.argv) <> 3:
    print """
    usage: %s <size> <n>
    generates files %s-<size>-<n>/d.pddl and %s/p.pddl

    for the problem of picking <n> objects at a unknown position
    of a grid of <size>x<size>
    but having a 'push' action for moving it conditionally.
    pickup is only appliable at the extremes of the grid
    """ % (sys.argv[0], name, name)
    sys.exit(1)
size = int(sys.argv[1])
n = int(sys.argv[2])

path=name+"-"+str(size)+"-"+str(n)
name_p="%s-%d-%d" % (name, size, n)

os.system("/bin/rm -rf ./"+path)
os.makedirs(path)

problem = file(path + "/ps-new.pddl", "w")
problem2 = file(path + "/ps-new2.pddl", "w")
problem3 = file(path + "/ps-new3.pddl", "w")
domain  = file(path + "/ds-new.pddl", "w")
domain2  = file(path + "/ds-new2.pddl", "w")

size+=1
n+=1

ctts = ''
whens = ''
whens1 = ''
for o in range(1, n):
    ctts += " o%d" % o
    whens  += """
		   (when (obj-at o%d ?i) (and (holding o%d) (not (obj-at o%d ?i))))""" % (o,o,o)		
    whens1 += """
                 (when (obj-at o%d ?i) (and (obj-at o%d ?j) (not (obj-at o%d ?i)) (ncleared ?j)))""" % (o,o,o)

d = """
(define (domain %s) 
""" % name + """
   (:requirements :strips :typing)
   (:types pos obj)
   (:constants %s - obj) 
   (:predicates (adj ?i ?j - pos) (at ?i - pos) (ncleared ?i - pos) (holding ?o - obj) (obj-at ?o - obj ?i - pos)
                (pick-loc ?i - pos))
   (:action move
      :parameters (?i - pos ?j - pos )
      :precondition (and (adj ?i ?j) (at ?i) (ncleared ?j))
      :effect (and (not (at ?i)) (at ?j)))
   (:action pickup
      :parameters (?i - pos )
      :precondition (and (at ?i) (pick-loc ?i))
      :effect (and %s)
   )
   (:action push
      :parameters (?i - pos  ?j - pos )
      :precondition (and (adj ?i ?j) (at ?i))
      :effect (and (not (ncleared ?i)) %s)
   )
)
""" % (ctts,whens,whens1)

d2 = """
(define (domain %s) 
""" % name + """
   (:requirements :strips)
   (:constants %s) 
   (:predicates (adj ?i ?j) (at ?i) (ncleared ?i) (holding ?o) (obj-at ?o ?i)
                (pick-loc ?i))
   (:action move
      :parameters (?i ?j)
      :precondition (and (adj ?i ?j) (at ?i) (ncleared ?j))
      :effect (and (not (at ?i)) (at ?j)))
   (:action pickup
      :parameters (?i)
      :precondition (and (at ?i) (pick-loc ?i))
      :effect (and %s)
   )
   (:action push
      :parameters (?i ?j)
      :precondition (and (adj ?i ?j) (at ?i))
      :effect (and (not (ncleared ?i)) %s)
   ))
""" % (ctts,whens,whens1)

print >> domain, d
print >> domain2, d2

head = "(define (problem %s)\n" % name_p + \
       "(:domain %s)\n" % name + \
       "\n (:objects "
head1 = "(define (problem %s)\n" % name_p + \
       "(:domain %s)\n" % name + \
       "\n (:objects %s - obj" % ctts
print >> problem, head
print >> problem2, head1
print >> problem3, head
head2=""
for x in range(1, size):
    for y in range(1, size):
        head2 += "    p%d-%d\n" % (x,y)
print >> problem, head2
print >> problem2, head2
print >> problem3, head2
print >> problem, " - pos "
head3 ="    )\n" 
head3 += "   (:init"
print >> problem, head3
print >> problem2, head3
print >> problem3, head3


print >> problem, "    (and"
part2 = "     (at p%d-%d)\n" % (size/2, size/2)
part2 += "     (pick-loc p%d-%d)" % (1,1)
part2 += "     (pick-loc p%d-%d)" % (size-1,size-1)
for x1 in range(1, size-1):
    for y1 in range(1, size):
        part2 += "     (adj p%d-%d p%d-%d)\n" % (x1,y1, x1+1,y1)
        part2 += "     (adj p%d-%d p%d-%d)\n" % (x1+1,y1, x1,y1)
        part2 += "\n"
part2 += "\n"

for y1 in range(1, size-1):
    for x1 in range(1, size):
        part2 += "     (adj p%d-%d p%d-%d)\n" % (x1,y1, x1,y1+1)
        part2 += "     (adj p%d-%d p%d-%d)\n" % (x1,y1+1, x1,y1)
        part2 += "\n"
    

print >> problem, part2
print >> problem2, part2
print >> problem3, part2


ncleared = ""
oneof = ""
unknown = ""
for o in range(1, n):
    oneof += "     (or\n" 
    for x in range(1, size):
        for y in range(1, size):
            oneof += "        (obj-at o%d p%d-%d)\n" % (o,x,y)
            unknown += "        (unknown (obj-at o%d p%d-%d))\n" % (o,x,y)			
    oneof += "     )\n" 
for x in range(1, size):
    for y in range(1, size):
	 ncleared += "        (ncleared p%d-%d)\n" % (x,y)

print >> problem, ncleared
print >> problem, oneof
print >> problem2, ncleared
print >> problem2, oneof
print >> problem2, unknown
print >> problem3, ncleared
print >> problem3, oneof

print >> problem, "    )"
goal=""
if n <= 2:
    goal = "(holding o1)"
else:
    goal += "(and "
    for o in range(1, n):
        goal += "    (holding o%d)\n" % o
    goal += ")"

end =  "    )\n    (:goal %s))" % goal

print >> problem, end
print >> problem2, end
print >> problem3, end

