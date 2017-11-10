
%------------GAME STATE-------------

play :-
	repeat,
		retract(state(Board, Count, Player)),
			printCurrentInfo(Board, Player),
			format('Count = ~p', [Count]), nl,
			once(move(Board, Player, FinalBoard)),
			changePlayer(Player, NextPlayer),
			Counter is Count - 1,
		assert(state(FinalBoard, Counter, NextPlayer)),
		endGame(Counter).


move(Board, Player, FinalBoard):-
		repeat,
			getCoordsFromUser(NLine, NCol),
			check(Board, NLine, NCol, NextBoard, Player),
			verifyRule(NextBoard, NLine, NCol, Player, FinalBoard).


getCoordsFromUser(NLine, NCol):-
		write('Type Board Coordinates: (Line. <enter> Column.)'), nl,
		read(NLine), nl, read(NCol).


check(Board, NLine, NCol, NextBoard, Player) :-
	getPiece(Board, NLine, NCol, X),
	(
		X == emptyCell -> setPiece(Board, NLine, NCol, Player, NextBoard);
		X \= emptyCell -> write('There is already a piece there! Try again!'), nl, fail
	).


verifyRule(Board, NLine, NCol, Player, FinalBoard):-
		getLine(Board, NLine, Line),
		testState(Line, NewLine, Player),
		replace(Board, NLine-1, NewLine, NewBoard),
		transpose(NewBoard, TBoard),
		getLine(TBoard, NCol, Col),
		testState(Col, NewCol, Player),
		replace(TBoard, NCol-1, NewCol, NewBoard2),
		transpose(NewBoard2, FinalBoard),
		printBoard(FinalBoard), nl.


changePlayer('O ', 'X ').
changePlayer('X ', 'O ').


endGame(Count) :-
	Count == 0,
	write('Acabou'), nl.
