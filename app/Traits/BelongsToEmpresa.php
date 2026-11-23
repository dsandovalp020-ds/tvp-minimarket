<?php

namespace App\Traits;

use App\Models\Empresa;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Facades\Auth;

trait BelongsToEmpresa
{
    protected static function bootBelongsToEmpresa(): void
    {
        static::addGlobalScope('empresa', function (Builder $builder) {
            if (Auth::check() && Auth::user()->empresa_id) {
                $builder->where(
                    $builder->getModel()->getTable() . '.empresa_id',
                    Auth::user()->empresa_id
                );
            }
        });

        static::saving(function (Model $model) {
            if (Auth::check() && Auth::user()->empresa_id) {
                $model->empresa_id = Auth::user()->empresa_id;
            }
        });
    }

    public function empresa(): BelongsTo
    {
        return $this->belongsTo(Empresa::class);
    }
}
