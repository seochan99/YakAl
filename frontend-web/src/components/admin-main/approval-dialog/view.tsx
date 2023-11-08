import * as S from "./style.ts";
import { DialogActions, DialogTitle } from "@mui/material";

type TApprovalDialog = {
  title: string;
  isOpen: boolean;
  onClose: () => void;
  onClickOkay: () => void;
  hasDepartment: boolean;
  department?: string;
  onChangeDepartment?: (event: React.ChangeEvent<HTMLInputElement>) => void;
};

function ApprovalDialog({
  title,
  isOpen,
  onClose,
  onClickOkay,
  hasDepartment,
  department,
  onChangeDepartment,
}: TApprovalDialog) {
  return (
    <S.StyledDialog open={isOpen} onClose={onClose} aria-labelledby="approval-dialog">
      <DialogTitle>{title}</DialogTitle>
      {hasDepartment && (
        <S.DepartmentInput
          value={department}
          onChange={onChangeDepartment}
          placeholder={"의사로 승인한다면 부여할 분과를 작성해주세요."}
        />
      )}
      <DialogActions>
        <S.CancelButton onClick={onClose}>{"취소"}</S.CancelButton>
        <S.OkayButton onClick={onClickOkay}>{"확인"}</S.OkayButton>
      </DialogActions>
    </S.StyledDialog>
  );
}

export default ApprovalDialog;
