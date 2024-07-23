; Function to compare two Atoms based on their metatypes (less than or equal to)
    ; (grounded < symbol < expression < variable)
(= (lte $a $b)
    (let* ( ($type-a (get-metatype $a))
            ($type-b (get-metatype $b)))
        (if (== $type-a $type-b)
            True
            (if (== $type-a Grounded)
                True
                (if (and (== $type-a Symbol) (or (== $type-b Expression) (== $type-b Variable)))
                    True
                    (if (and (== $type-a Expression) (== $type-b Variable))
                        True
                        False ;; add other conditions
                    )
                ))
        )
    )
)

; Fnuction to sort an outer expression based on their metatypes
(= (sort $expr)
    (case $expr
        (
            (($OP $a $b) 
                (if (lte $a $b)
                    ($OP $a $b)
                    ($OP $b $a)
                )
            )
            ($else $expr)
        )
    )
)

; Function to check whether a certain sub-expression is part of another expression
(= (member $op $sub_exp $EXP)
    (if (== (get-metatype $EXP) Expression)
        (case $EXP
            (
                ( ($op $a $b) (or (member $op $sub_exp $a) (member $op $sub_exp $b)) )
                ( $else (== $sub_exp $EXP) )
            )
        )
        (== $sub_exp $EXP)
    )
)

;** TODO **
; Write other helper functions: equal | subset