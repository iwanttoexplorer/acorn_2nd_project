package com.acorn.doma.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.Search;
import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Accident;
import com.acorn.doma.domain.Board;
import com.acorn.doma.domain.User;

@Mapper
public interface BoardMapper extends WorkDiv<Board>{

	
	/**
	 * 최신 sequence 조회
	 * @return
	 * @throws SQLException
	 */
	int getSequence() throws SQLException;
	
	/**
	 * 테스트용 데이터 전체 삭제
	 * @return
	 * @throws SQLException
	 */
	int deleteAll() throws SQLException;
	
	/**
	 * 조회 count증가
	 * @param inVO
	 * @return
	 * @throws SQLException
	 */
	int readCntUpdate(Board inVO) throws SQLException;
	
	/**
	 * 다건 데이터 등록
	 * @return
	 * @throws SQLException
	 */
	int multipleSave() throws SQLException;
	
	
	/**
	 * 마이페이지 전체 데이터 조회
	 * @return
	 * @throws SQLException
	 */
	List<Board> mpSelect(Board inVO) throws SQLException; 
	
	List<Board> mpSelect(String userId); 
	
	Board mpBoardSelectOne(Board inVO) throws SQLException;
	
	int mpBoardUp(Board inVO) throws SQLException;
	
	
	//안전정보페이지에서 사용할 메서드
	int Save(Board inVO)throws SQLException;
	
	List<Board> Retrieve(Search search) throws SQLException;
}
