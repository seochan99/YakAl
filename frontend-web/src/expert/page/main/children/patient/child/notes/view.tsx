import * as S from "./style.ts";

import AddOutlinedIcon from "@mui/icons-material/AddOutlined";
import Pagination from "react-js-pagination";
import { useState } from "react";
import { Dialog, useMediaQuery, useTheme } from "@mui/material";
import { ListFooter } from "../../../../../../style.ts";

export type TSpecialNoteProps = {
  patientId: number;
};

const PAGING_PAGE = 5;

function SpecialNote() {
  const [createIsOpen, setCreateIsOpen] = useState<boolean>(false);
  const [page, setPage] = useState<number>(1);
  const [currentTitle, setCurrentTitle] = useState<string>("");
  const [currentDescription, setCurrentDescription] = useState<string>("");

  const theme = useTheme();
  const fullScreen = useMediaQuery(theme.breakpoints.down("sm")); // width: 600px

  const handlePageChange = (page: number) => {
    setPage(page);
  };

  const handleDialogClose = () => {
    setCurrentTitle("");
    setCurrentDescription("");
  };

  const handleCreateDialogClose = () => {
    setCreateIsOpen(false);
    setCurrentTitle("");
    setCurrentDescription("");
  };

  const currentNote = {
    createDate: [2022, 12, 12],
  };

  return (
    <>
      <S.Header>
        <S.Title>특이 사항</S.Title>
        <S.AddButton onClick={() => setCreateIsOpen(true)}>
          <AddOutlinedIcon />
          추가
        </S.AddButton>
      </S.Header>
      <S.Bar />
      <S.List>
        <S.ListHeader>
          <S.TitleHeader>제목</S.TitleHeader>
          <S.RecordedDateHeader>기록일</S.RecordedDateHeader>
        </S.ListHeader>
        <S.Item key={1} onClick={() => console.log("haha")}>
          <S.ItemTitle>
            {"안녕하세요".length > 15 ? "안녕하세요".substring(0, 14).concat("...") : "안녕하세요"}
          </S.ItemTitle>
          <S.ItemRecordedDate>{`2022. 12. 12.`}</S.ItemRecordedDate>
        </S.Item>
      </S.List>
      <ListFooter>
        <Pagination
          activePage={page}
          itemsCountPerPage={PAGING_PAGE}
          totalItemsCount={10}
          pageRangeDisplayed={3}
          prevPageText={"‹"}
          nextPageText={"›"}
          onChange={handlePageChange}
        />
      </ListFooter>
      <Dialog open={currentNote !== null} onClose={handleDialogClose} fullScreen={fullScreen} keepMounted>
        <S.DialogBox>
          <S.DialogHeader>
            <S.DialogTitle>특이 사항 수정</S.DialogTitle>
            <S.DialogRecordDate>
              {"기록일: "}
              {currentNote &&
                currentNote.createDate &&
                `${currentNote.createDate[0]}. ${
                  currentNote.createDate[1] < 10
                    ? "0".concat(currentNote.createDate[1].toString())
                    : currentNote.createDate[1]
                }. ${
                  currentNote.createDate[2] < 10
                    ? "0".concat(currentNote.createDate[2].toString())
                    : currentNote.createDate[2]
                }.`}
            </S.DialogRecordDate>
          </S.DialogHeader>
          <S.Bar />
          <S.DialogInputBox>
            <S.Label>제목</S.Label>
            <S.NoteTitleInput value={currentTitle} onChange={(e) => setCurrentTitle(e.target.value)} />
            <S.Label>내용</S.Label>
            <S.NoteDescriptionInput
              value={currentDescription}
              onChange={(e) => setCurrentDescription(e.target.value)}
            />
          </S.DialogInputBox>
          <S.DialogFooter>
            <S.DialogDeleteButton onClick={() => console.log("삭제")}>삭제</S.DialogDeleteButton>
            <S.DialogCancelButton onClick={handleDialogClose}>취소</S.DialogCancelButton>
            <S.DialogConfirmButton onClick={() => console.log("수정")}>수정</S.DialogConfirmButton>
          </S.DialogFooter>
        </S.DialogBox>
      </Dialog>
      <Dialog open={createIsOpen} onClose={handleCreateDialogClose} fullScreen={fullScreen} keepMounted>
        <S.DialogBox>
          <S.DialogHeader>
            <S.DialogTitle>특이 사항 추가</S.DialogTitle>
          </S.DialogHeader>
          <S.Bar />
          <S.DialogInputBox>
            <S.Label>제목</S.Label>
            <S.NoteTitleInput value={currentTitle} onChange={(e) => setCurrentTitle(e.target.value)} />
            <S.Label>내용</S.Label>
            <S.NoteDescriptionInput
              value={currentDescription}
              onChange={(e) => setCurrentDescription(e.target.value)}
            />
          </S.DialogInputBox>
          <S.DialogFooter>
            <S.DialogCancelButton onClick={handleDialogClose}>취소</S.DialogCancelButton>
            <S.DialogConfirmButton onClick={() => console.log("추가")}>추가</S.DialogConfirmButton>
          </S.DialogFooter>
        </S.DialogBox>
      </Dialog>
    </>
  );
}

export default SpecialNote;
