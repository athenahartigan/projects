import 'package:quiz_app/models/quiz_question.dart';

const questions = [
  QuizQuestion(
    'What is the max number of nodes a tree of height h can have?',
    [
      '2^(h + 1) - 1',
      '2h',
      'h^2',
      'log(h)',
    ],
  ),
  QuizQuestion('What base is implied for log in computer science?', [
    '2',
    '10',
    '1',
    'None of these',
  ]),
  QuizQuestion('What is the time complexity of finding a value in a binary search tree? (N is the number of nodes in the tree)', [
    'O(log(N)) if the tree is complete, otherwise O(N)',
    'O(log(N)) because at each traversal we elimate half the nodes',
    'O(Nlog(N)) because each node takes log(N) time to check',
    'O(N) because we have to go through every node in the tree',
  ]),
  QuizQuestion('How many recursive calls would it take to find a node in a balanced binary search tree with 1,000,000 children', [
    '20',
    '1,000,000',
    '1',
    'sqrt(1,000,000)',
  ]),
  QuizQuestion('Aproximately what is log(1,000,000)?', [
    '20',
    '1,000',
    '1',
    '10,000',
  ]),
  QuizQuestion('Which data structure removes from the end in O(1) time?', [
    'ArrayList',
    'Priority Queue',
    'Array',
  ]),
  QuizQuestion(
    'What is the time complexity of adding and removing from a priority queue?',
    [
      'O(log(N))',
      'O(1)',
      'O(N^2)',
      'O(N)',
    ],
  ),
  QuizQuestion(
    'What is the time complexity of BFS?',
    [
      'O(V + E)',
      'O(E)',
      'O(V * E)',
      'O(V)',
    ],
  ),
  QuizQuestion(
    'Generally, which of these takes less lines of code but more space complexity?',
    [
      'Recursion, but requires more space due to the call stack',
      'Iteration, but requires more space due to the loop',
    ],
  ),
  QuizQuestion(
    'In a sorted array of a million numbers, what is the max number of recursive calls needed in a recursive binary search algorithm?',
    [
      '20',
      '1,000,000',
      '1',
      'You can\'t use binary search for this problem',
    ],
  ),
  QuizQuestion('Which time complexity is the worst?', [
    'O(N^N)',
    'O(N!)',
    'O(N*N*N)',
    'O(1000000*N*N)',
  ]),
  QuizQuestion('Which time complexity is the worst?', [
    'O(N*sqrt(N))',
    'O(1000*N*log(N))',
    'O(1000*N)',
    'O(N*log(N^50))',
  ]),
  QuizQuestion('log(N^20) equals:', [
    '20log(N)',
    '4log(N)',
    'log(N)',
    'None of these',
  ]),
  QuizQuestion('What is log(2^20)?', [
    'exactly 20, 20log(2) = 20, log(2) = 1, 1*20=20',
    'about 20',
    '10',
    '15',
    '25',
  ]),
  QuizQuestion('What sorting algorithms runs in O(N) time?', [
    'Quickselect',
    'Merge Sort',
    'Quicksort',
    'Bubble Sort',
  ]),
  QuizQuestion('What data structure is good for keeping track of the k largest values?', [
    'Priority Queue',
    'ArrayList',
    'Queue',
    'None of these',
  ]),
  QuizQuestion('What data structure lets you remove a key value pair in O(1) time?', [
    'Hashmap',
    'Hashset',
    'Priority Queue',
    'Queue',
  ]),
  QuizQuestion('How do hashmaps get the value in O(1) time?', [
    'It runs the key through a hash function to find where the value is stored in some set of space',
    'It just knows where it is by storing the location of the value',
    'Its saved next to the key',
  ]),
  QuizQuestion('Which could happen if there is a colision in a hashmap?', [
    'The hashmap could use a linked list to store the colision entries',
    'That can\'t happen each value is unique',
    'The code breaks',
    'The hashmap could store the collisions in a priority queue',
  ]),
  QuizQuestion('If you have a horrible hash function and all your keys collide in a hashmap what is the time complexity of the hashmap?', [
    'O(N), but a good hashfunction wouldn\'t have many colisions',
    'O(N), this is common',
    'O(1)',
    'O(log(N))',
  ]),
  QuizQuestion('Is a priority queue in Java naturally a min or max heap?', [
    'Minheap',
    'Maxheap',
  ]),
  QuizQuestion('How can you make a minheap a maxheap?', [
    'Both of these',
    'PriorityQueue<Integer> pQueue = new PriorityQueue<Integer>(Collections.reverseOrder());',
    'Make the numbers negative',
  ]),
  QuizQuestion('How do you get the size of an array in Java?', [
    '.length',
    '.length()',
    '.size()',
    '.size',
  ]),
  QuizQuestion('How do you get the size of an string in Java?', [
    '.length()',
    '.length',
    '.size()',
    '.size',
  ]),
  QuizQuestion('How do you get the size of an arraylist in Java?', [
    '.size()',
    '.length()',
    '.length',
    '.size',
  ]),
  QuizQuestion(
    'Which sorting algorthm always sorts faster than O(N^2)?',
    [
      'Merge sort',
      'Quicksort',
      'Quickselect',
      'Bubble sort',
    ],
  ),
];