package com.example.jpaboard.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.example.jpaboard.entity.Board;

public interface BoardRepository extends JpaRepository<Board, Integer> {
	
	Page<Board> findByboardTitleContaining(Pageable pageable, String word);
}
