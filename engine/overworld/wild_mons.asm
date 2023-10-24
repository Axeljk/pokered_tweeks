LoadWildData::
	ld hl, WildDataPointers
	ld a, [wCurMap]

	; get wild data for current map
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a       ; hl now points to wild data for current map
	ld bc, $15
	ld a, [hli]
	cp $ff
	jr nz, .NoAlternates
	ld a, [wPlayerID]
	and $3
	cp $0
	jr z, .first
	cp $1
	jr nz, .done
	add hl, bc
.first
	add hl, bc
.done
	ld a, [hli]
.NoAlternates
	ld [wGrassRate], a
	and a
	jr z, .NoGrassData ; if no grass data, skip to surfing data
	push hl
	ld de, wGrassMons ; otherwise, load grass data
	ld bc, $14
	call CopyData
	pop hl
	ld bc, $14
	add hl, bc
.NoGrassData
	ld a, [hli]
	ld [wWaterRate], a
	and a
	ret z        ; if no water data, we're done
	ld de, wWaterMons  ; otherwise, load surfing data
	ld bc, $14
	jp CopyData

INCLUDE "data/wild/grass_water.asm"
