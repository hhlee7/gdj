package com.example.jpaboard.repository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.example.jpaboard.entity.Article;

public interface ArticleRepository extends JpaRepository<Article, Long>{
	// CrudRepository : insert, select one, select all, update, delete
	
	// JpaRepository(CrudRepository 자식 인터페이스) : select limit, select order by, ...
	
	Page<Article> findByTitleContaining(Pageable pageable, String word);
}
