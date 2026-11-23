<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SyncEvent extends Model
{
    protected $primaryKey = 'event_id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = ['event_id', 'empresa_id', 'event_type', 'result'];

    protected function casts(): array
    {
        return ['result' => 'array'];
    }

    public function empresa(): BelongsTo
    {
        return $this->belongsTo(Empresa::class);
    }
}
