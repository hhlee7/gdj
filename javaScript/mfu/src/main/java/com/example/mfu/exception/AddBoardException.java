package com.example.mfu.exception;

public class AddBoardException extends RuntimeException {
	public AddBoardException() {
	}
	public AddBoardException(String message) {
		super(message);
	}
}