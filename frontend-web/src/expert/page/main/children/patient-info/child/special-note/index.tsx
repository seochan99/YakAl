import {
  AddButton,
  Bar,
  DialogBox,
  DialogCancelButton,
  DialogConfirmButton,
  DialogDeleteButton,
  DialogFooter,
  DialogHeader,
  DialogInputBox,
  DialogRecordDate,
  DialogTitle,
  Header,
  Item,
  ItemRecordedDate,
  ItemTitle,
  Label,
  List,
  ListHeader,
  NoteDescriptionInput,
  NoteTitleInput,
  RecordedDateHeader,
  Title,
  TitleHeader,
} from "./style.ts";

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
      <Header>
        <Title>특이 사항</Title>
        <AddButton onClick={() => setCreateIsOpen(true)}>
          <AddOutlinedIcon />
          추가
        </AddButton>
      </Header>
      <Bar />
      <List>
        <ListHeader>
          <TitleHeader>제목</TitleHeader>
          <RecordedDateHeader>기록일</RecordedDateHeader>
        </ListHeader>
        <Item key={1} onClick={() => console.log("haha")}>
          <ItemTitle>{"안녕하세요".length > 15 ? "안녕하세요".substring(0, 14).concat("...") : "안녕하세요"}</ItemTitle>
          <ItemRecordedDate>{`2022. 12. 12.`}</ItemRecordedDate>
        </Item>
      </List>
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
        <DialogBox>
          <DialogHeader>
            <DialogTitle>특이 사항 수정</DialogTitle>
            <DialogRecordDate>
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
            </DialogRecordDate>
          </DialogHeader>
          <Bar />
          <DialogInputBox>
            <Label>제목</Label>
            <NoteTitleInput value={currentTitle} onChange={(e) => setCurrentTitle(e.target.value)} />
            <Label>내용</Label>
            <NoteDescriptionInput value={currentDescription} onChange={(e) => setCurrentDescription(e.target.value)} />
          </DialogInputBox>
          <DialogFooter>
            <DialogDeleteButton onClick={() => console.log("삭제")}>삭제</DialogDeleteButton>
            <DialogCancelButton onClick={handleDialogClose}>취소</DialogCancelButton>
            <DialogConfirmButton onClick={() => console.log("수정")}>수정</DialogConfirmButton>
          </DialogFooter>
        </DialogBox>
      </Dialog>
      <Dialog open={createIsOpen} onClose={handleCreateDialogClose} fullScreen={fullScreen} keepMounted>
        <DialogBox>
          <DialogHeader>
            <DialogTitle>특이 사항 추가</DialogTitle>
          </DialogHeader>
          <Bar />
          <DialogInputBox>
            <Label>제목</Label>
            <NoteTitleInput value={currentTitle} onChange={(e) => setCurrentTitle(e.target.value)} />
            <Label>내용</Label>
            <NoteDescriptionInput value={currentDescription} onChange={(e) => setCurrentDescription(e.target.value)} />
          </DialogInputBox>
          <DialogFooter>
            <DialogCancelButton onClick={handleDialogClose}>취소</DialogCancelButton>
            <DialogConfirmButton onClick={() => console.log("추가")}>추가</DialogConfirmButton>
          </DialogFooter>
        </DialogBox>
      </Dialog>
    </>
  );
}

export default SpecialNote;
