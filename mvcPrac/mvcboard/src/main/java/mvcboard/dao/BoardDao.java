package mvcboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mvcboard.dto.Board;
import mvcboard.dto.Page;
import mvcboard.util.DBUtil;

public class BoardDao { // Data Access Object
    // 글수정 메서드
    public int updateBoard(Board board) {
        Connection connection = null;
        PreparedStatement statement = null;
        int row = 0;
        try {
            connection = DBUtil.getConnection();
            String sql = "UPDATE board SET board_title=?, board_content=? WHERE board_no=? AND board_pw=?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, board.getBoardTitle());
            statement.setString(2, board.getBoardContent());
            statement.setInt(3, board.getBoardNo());
            statement.setString(4, board.getBoardPw());
            row = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print("예외 발생");
        } finally {
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        } 
        return row;
    }
    
    
    // 글번호와 글패스워드를 입력받아 한개의 게시글 삭제
    public int deleteBoard(int boardNo, String boardPw) {
        Connection connection = null;
        PreparedStatement statement = null;
        int row = 0;
        try {
            connection = DBUtil.getConnection();
            String sql = "DELETE FROM board WHERE board_no=? AND board_pw=?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, boardNo);
            statement.setString(2, boardPw);
            row = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print("예외 발생");
        } finally {
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        } 
        return row;
    }
    
    // 한개의 게시글 내용보기
    public Board selectBoardOne(int boardNo) {
        Board board = null;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = DBUtil.getConnection();
            String sql = "SELECT board_title, board_content, board_user, board_date FROM board WHERE board_no=?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, boardNo);
            rs = statement.executeQuery();
            if(rs.next()) {
                board = new Board();
                board.setBoardNo(boardNo);
                board.setBoardTitle(rs.getString("board_title"));
                board.setBoardContent(rs.getString("board_content"));
                board.setBoardUser(rs.getString("board_user"));
                board.setBoardDate(rs.getString("board_date"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print("예외 발생");
        } finally {
            try {rs.close();} catch(Exception e){}
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        }   
        return board;
    }
    
    // 게시글 목록
    public ArrayList<Board> selectBoardList(Page page) {
        ArrayList<Board> list = new ArrayList<Board>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = DBUtil.getConnection();
            String listSql = "SELECT board_no, board_title, board_user, board_date FROM board ORDER BY board_date DESC LIMIT ?, ?";
            statement = connection.prepareStatement(listSql);
            statement.setInt(1, page.getBeginRow()); 
            statement.setInt(2, page.getRowPerPage()); 
            rs = statement.executeQuery();
            while(rs.next()) {
                Board board = new Board();
                board.setBoardNo(rs.getInt("board_no"));
                board.setBoardTitle(rs.getString("board_title"));
                board.setBoardUser(rs.getString("board_user"));
                board.setBoardDate(rs.getString("board_date"));
                list.add(board);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print("예외 발생");
        } finally {
            try {rs.close();} catch(Exception e){}
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        }
        return list;
    }
    
    // 전체 글 카운트
    public int selectBoardCount() {
        int count = 0; 
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = DBUtil.getConnection();
            String totalSql = "SELECT COUNT(*) FROM board"; // board테이블의 전체행의 수를 반환
            statement = connection.prepareStatement(totalSql);
            rs = statement.executeQuery();
            if(rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print("예외 발생");
        } finally {
            try {rs.close();} catch(Exception e){}
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        }
        return count;
    }
    
    // 글쓰기 메서드
    public int insertBoard(Board board) {
        Connection connection = null;
        PreparedStatement statement = null;
        int row = 0;
        try {
            connection = DBUtil.getConnection();
            String sql = "INSERT INTO board(board_pw, board_title, board_content, board_user, board_date) values(?,?,?,?,now())";
            statement = connection.prepareStatement(sql);
            statement.setString(1,board.getBoardPw());
            statement.setString(2,board.getBoardTitle());
            statement.setString(3,board.getBoardContent());
            statement.setString(4,board.getBoardUser());
            row = statement.executeUpdate(); // insert 쿼리를 실행
        } catch(Exception e) {
            e.printStackTrace();
            System.out.print("예외 발생");
        } finally {
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        }
        return row;
    }
}
